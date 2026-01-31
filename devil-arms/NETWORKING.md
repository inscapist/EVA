# Networking Configuration (WARP + Tailscale)

This module (`networking.nix`) configures the system's networking stack, with a specific focus on making **Cloudflare WARP (Teams)** and **Tailscale** coexist peacefully on NixOS.

## The Challenge

Running Cloudflare WARP and Tailscale simultaneously on NixOS often leads to connectivity deadlocks due to:
1.  **Reverse Path Filtering (`rp_filter`):** The kernel drops asymmetric return packets from VPN interfaces.
2.  **DNS Bootstrap Loops:** WARP tries to route its own DNS queries through the tunnel before the tunnel is established.
3.  **Firewall Backend Mismatches:** WARP expects `iptables` legacy rules, while modern NixOS defaults to `nftables`.
4.  **NetworkManager Interference:** NetworkManager attempts to manage VPN interfaces, breaking their internal routing.

## Configuration Details

### 1. Cloudflare WARP Fixes
To prevent the "Connecting..." hang and DNS outage:

*   **Firewall Backend:** We explicitly set `networking.nftables.enable = false` to force the legacy `iptables` backend, which WARP's `warp-svc` relies on.
*   **Reverse Path Filter:** We disable strict `rp_filter` validation (`networking.firewall.checkReversePath = false`) and ensure `security.nix` does not override this.
*   **Unmanaged Interface:** `CloudflareWARP` is added to `networking.networkmanager.unmanaged` to stop NetworkManager from resetting its IP/DNS.

### 2. Tailscale Integration
*   **Package:** `tailscale` is added to system packages.
*   **Firewall:** Port `41641` (UDP) is open, and `tailscale0` is a trusted interface.
*   **Unmanaged:** `tailscale0` is also unmanaged by NetworkManager.
*   **DNS Takeover Guard:** When Tailscale is enabled, a `tailscale-preferences` systemd unit (plus timer) runs `tailscale set --accept-dns=false` to prevent Tailscale/MagicDNS from rewriting system DNS in dual-VPN setups.

## Included Utility Scripts

This configuration installs several helper scripts to the system path:

### `warp-fix` (Run Once)
**Crucial utility** to resolve the "Chicken-and-Egg" DNS deadlock.
*   **What it does:**
    1.  Disconnects WARP.
    2.  **Excludes** Cloudflare DNS (`1.1.1.1`, `1.0.0.1`) from the tunnel. This ensures WARP can always resolve its own endpoints via the physical interface.
    3.  **Disables Connectivity Checks:** Prevents the daemon from hanging at "PerformingConnectivityChecks" (a common false negative in dual-VPN setups).
    4.  Reconnects.
*   **Usage:** Run `warp-fix` after initial enrollment or if you reset WARP settings.

### `warp-enroll [org_name]`
Helper to register with Cloudflare Zero Trust (Teams).
*   **Usage:** `warp-enroll <your-team-name>`
*   Handles the token flow and setup cleanly.

### `warp-status`
Provides a detailed JSON status and checks `curl` trace output to verify that traffic is actually being encrypted (`warp=on`), even if the CLI says "Connecting".

### `warp-connected`
A scriptable check (exit code 0 or 1) used by automation to verify the tunnel is active and secure.

## Troubleshooting

**Symptom:** WARP stuck at "Connecting" (Reason: `PerformingConnectivityChecks` or `ConfiguringFirewallRules`).
**Solution:**
1.  Ensure you have run `sudo nixos-rebuild switch`.
2.  Run `warp-fix` in the terminal.
3.  Check `warp-status`. If `warp=on` and `gateway=on` in the trace output, you are secure, even if the status says "Connecting".

**Symptom:** Internet/DNS "dies" after enabling Tailscale (websites don't resolve).
**Solution:**
1.  Run: `sudo tailscale set --accept-dns=false`
1.  (If you previously used an exit node) Run: `sudo tailscale set --exit-node=`
2.  Verify with: `resolvectl status` (your global DNS should still be `1.1.1.1` / `1.0.0.1`).
