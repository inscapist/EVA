# Networking Configuration (WARP vs Tailscale)

This module (`networking.nix`) configures the system's networking stack. Due to fundamental routing conflicts between **Cloudflare WARP (Teams)** and **Tailscale** on Linux, this configuration enforces a **Mutually Exclusive** operating mode.

**You can run WARP or Tailscale, but NOT both simultaneously.**

## Quick Usage

We provide shell aliases to switch modes easily:

*   `run-warp`: Stops Tailscale and starts Cloudflare WARP.
*   `run-tailscale`: Stops WARP and starts Tailscale.

## The Architecture

### 1. Cloudflare WARP (Enterprise/Teams)
*   **Routing Bypass**: The service automatically detects your default gateway on startup and injects specific routes to bypass the tunnel for Cloudflare endpoints. This prevents the "Connecting..." hang caused by routing loops.
*   **IPv6 Blackhole**: IPv6 is explicitly blocked for WARP endpoints to prevent "Happy Eyeballs" timeouts.
*   **DNS Safety**: The service automatically strips DNS configuration from the `CloudflareWARP` interface to prevent it from hijacking system DNS and causing loops.
*   **System DNS**: We use `8.8.8.8` as the primary system resolver to avoid Cloudflare internal routing interception during tunnel bootstrap.

### 2. Tailscale
*   **Conflict Management**: The `tailscaled` service is configured to `Conflict` with `cloudflare-warp`. Starting one automatically stops the other.
*   **DNS Protection**: A helper service (`tailscale-preferences`) ensures that even when Tailscale is running, it does not overwrite your global DNS settings (`--accept-dns=false`), preserving your ability to browse if the tailnet has issues.

## Troubleshooting

**Symptom:** WARP stuck at "Connecting".
**Solution:**
1.  Run `run-warp` (this restarts the service and re-applies the routing fixes).
2.  Check `warp-status`.

**Symptom:** Tailscale doesn't connect.
**Solution:**
1.  Run `run-tailscale`.
2.  Check `tailscale status`.
