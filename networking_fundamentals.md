# Networking Fundamentals: Anatomy of the Fix

This document breaks down the networking concepts behind the issues you faced (Docker connectivity, VPN conflicts, DNS failures) and explains *why* the specific fixes worked.

## 1. The Routing "Hijack" (Tailscale Exit Nodes)

**The Symptom:** You couldn't reach your Docker container (`172.17.x.x`), even though it was running locally.

### How it works
Linux determines where to send a packet using **Routing Tables**.
*   **Main Table:** Contains your standard routes (LAN, Wi-Fi gateway, Docker subnets).
*   **Table 52 (Tailscale):** Created by Tailscale to manage VPN traffic.

When you enable a Tailscale **Exit Node**, Tailscale installs a high-priority rule (`ip rule`) that says: *"Send ALL traffic to Table 52 first."*

### The Problem
Table 52 has a default route (`0.0.0.0/0 -> tailscale0`). By default, it blindly sucks in *everything*, including traffic destined for local private ranges like Docker's `172.17.0.0/16`.
*   **Result:** Your request to the local container was sent into the encrypted VPN tunnel. The Exit Node (somewhere on the internet) received it, saw a private IP, and dropped it (as it's unroutable on the public internet).

### The Fix
`tailscale up --exit-node-allow-lan-access=true`
This flag tells Tailscale to insert "throw" rules into Table 52 for local subnets (like `172.x.x.x`). A "throw" rule tells the kernel: *"I don't want this packet; go back and check the Main Table."*
*   **Outcome:** Traffic to Docker falls through to the Main Table, which correctly routes it to the `docker0` bridge.

---

## 2. MTU: The "Silent Killer" of Connections

**The Symptom:** `nc 127.0.0.1 5432` worked (connection established), but `psql ...` timed out or hung.

### What is MTU?
**Maximum Transmission Unit (MTU)** is the largest single packet that can be sent over a network interface.
*   **Ethernet/Docker Default:** 1500 bytes.
*   **VPNs (Tailscale/WARP):** ~1280 bytes (overhead from encryption headers reduces usable space).

### The Problem
1.  **Handshake (Works):** `nc` starts a TCP connection. The initial "Hello" (SYN) packets are tiny (~60 bytes). They fit easily through the VPN interface (1280) and Docker interface (1500). Connection succeeds!
2.  **Data Transfer (Fails):** `psql` tries to send authentication data or a large query response. These packets often fill the frame (1500 bytes).
3.  **The Drop:** The packet leaves the container (1500 bytes). It hits a network link (like the VPN interface or a path constrained by it) that only supports 1280 bytes.
    *   Usually, the router sends back an ICMP error: *"Packet too big, please fragment."*
    *   **Firewalls often block ICMP.** If this error is blocked, the sender never knows to shrink the packet. It keeps resending the big packet, which keeps getting dropped. This is a **Path MTU Discovery (PMTUD) Black Hole**.

### The Fix
We forced Docker to use `mtu = 1280` in `daemon.json`.
*   **Outcome:** The container now breaks data into smaller chunks (max 1280 bytes) *before* sending. These packets fit through every pipe in your network (Docker -> Bridge -> VPN -> Internet), so no drops occur.

---

## 3. Firewall Trust Zones

**The Symptom:** Packets reached the container, but replies were dropped, or `nc` timed out when using custom networks.

### How it works
NixOS uses a strict firewall (`nixos-fw`). By default, it blocks all incoming traffic on external interfaces unless related to an existing connection.

### The Problem
Docker uses `iptables` rules to forward traffic (NAT), but for **Host-to-Container** communication:
1.  You send a packet to `172.17.0.2` via `docker0`.
2.  The container replies.
3.  The reply arrives on the `docker0` interface.
4.  `nixos-fw` sees an incoming packet on `docker0`. If it doesn't explicitly trust this interface, it might drop the packet depending on strictness settings, breaking the handshake.

### The Fix
`networking.firewall.trustedInterfaces = [ "docker0" ... ];`
*   **Outcome:** We explicitly told NixOS: *"Traffic coming from the Docker bridge is safe."* This ensures return traffic from containers is never blocked.

---

## 4. DNS Caching & Stale State

**The Symptom:** `curl` worked, but the browser said "DNS_PROBE_POSSIBLE".

### The Hierarchy
1.  **Application (Browser/psql):** Asks the system "What is google.com?"
2.  **nscd (Name Service Cache Daemon):** A high-speed cache. Checks if it knows the answer. If yes, returns it instantly.
3.  **glibc Resolver:** If not in cache, asks the OS resolver.
4.  **systemd-resolved:** The system DNS manager. Queries the configured servers (1.1.1.1 or 100.100.100.100).

### The Problem
While we were fixing the network, the routing was broken. `systemd-resolved` might have received "Unreachable" errors or bad data. `nscd` **cached these failures**.
Even after we fixed the network (`curl` worked because it often bypasses `nscd` or retries aggressively), your browser asked `nscd`, which immediately replied with the cached failure: *"I checked 5 minutes ago and it was broken, so it's still broken."*

### The Fix
`sudo systemctl restart nscd`
*   **Outcome:** We flushed the cache. The next time the browser asked, `nscd` was empty, so it was forced to ask `systemd-resolved` again. Since the network was fixed, `systemd-resolved` got the correct IP, stored it, and your browser worked.
