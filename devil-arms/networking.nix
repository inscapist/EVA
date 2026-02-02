{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  tailscaleInterface = config.services.tailscale.interfaceName;
  tailscaleInterfaceArg = lib.escapeShellArg tailscaleInterface;
in
{
  services = {
    tailscale.enable = true;
    openssh.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
      dnsovertls = "opportunistic";
      llmnr = "true";
      extraConfig = ''
        Domains=~.
        MulticastDNS=true
        Cache=yes
        DNSStubListener=yes
      '';
    };

    # https://community.cloudflare.com/t/how-to-register-into-a-team-with-linux-and-warp-cli/627971
    cloudflare-warp = {
      enable = false;
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "warp-enroll";
      runtimeInputs = [
        pkgs.cloudflare-warp
        pkgs.curl
        pkgs.gnugrep
        pkgs.coreutils
        pkgs.systemd
      ];
      text = ''
        set -euo pipefail

        usage() {
          cat <<'EOF'
        Usage: warp-enroll [org]

        One-time Cloudflare Zero Trust (Teams) enrollment via warp-cli.

        Example:
          warp-enroll talenox
        EOF
        }

        if [[ "''${1:-}" == "-h" || "''${1:-}" == "--help" ]]; then
          usage
          exit 0
        fi

        org="''${1:-talenox}"

        if [[ "''${EUID:-$(id -u)}" -eq 0 ]]; then
          echo "Run as a regular user (Teams enrollment is not supported as root)." >&2
          exit 1
        fi

        sudo_cmd=""
        if [[ -x /run/wrappers/bin/sudo ]]; then
          sudo_cmd="/run/wrappers/bin/sudo"
        fi

        have_sudo=0
        if [[ -n "$sudo_cmd" ]]; then
          have_sudo=1
        fi

        reg_present_user() {
          warp-cli --accept-tos registration show >/dev/null 2>&1
        }

        reg_present_root() {
          if [[ "$have_sudo" -ne 1 ]]; then
            return 1
          fi
          "$sudo_cmd" warp-cli --accept-tos registration show >/dev/null 2>&1
        }

        restart_warp_daemon() {
          if [[ "$have_sudo" -ne 1 ]]; then
            return 0
          fi
          "$sudo_cmd" systemctl restart cloudflare-warp.service >/dev/null 2>&1 || true
          sleep 1
        }

        clean_system_registration() {
          if [[ "$have_sudo" -ne 1 ]]; then
            return 0
          fi

          "$sudo_cmd" warp-cli --accept-tos disconnect >/dev/null 2>&1 || true
          "$sudo_cmd" warp-cli --accept-tos registration delete >/dev/null 2>&1 || true

          "$sudo_cmd" systemctl stop cloudflare-warp.service >/dev/null 2>&1 || true
          "$sudo_cmd" rm -f /var/lib/cloudflare-warp/reg.json /var/lib/cloudflare-warp/reg_mdm_orgs.json
          "$sudo_cmd" systemctl start cloudflare-warp.service >/dev/null 2>&1 || true
          sleep 1
        }

        warp-cli --accept-tos disconnect >/dev/null 2>&1 || true

        warp-cli --accept-tos registration delete >/dev/null 2>&1 || true
        if reg_present_root; then
          "$sudo_cmd" warp-cli --accept-tos registration delete >/dev/null 2>&1 || true
        fi
        clean_system_registration
        restart_warp_daemon

        if reg_present_user || reg_present_root; then
          echo "Old registration is still around; delete it and retry:" >&2
          echo "  warp-cli --accept-tos registration delete" >&2
          echo "  /run/wrappers/bin/sudo warp-cli --accept-tos registration delete" >&2
          echo "If that still fails, run: /run/wrappers/bin/sudo rm -f /var/lib/cloudflare-warp/reg.json /var/lib/cloudflare-warp/reg_mdm_orgs.json" >&2
          exit 1
        fi

        echo "Open this URL and finish login:"
        echo "  https://''${org}.cloudflareaccess.com/warp"
        echo
        warp-cli --accept-tos registration new "''${org}"
        echo
        echo "Paste the 'com.cloudflare.warp://...token=...' link (inspect the button):"
        read -r -s token_url
        echo

        if [[ -z "''${token_url}" ]]; then
          echo "No token URL provided; aborting." >&2
          exit 1
        fi

        token_err="$(
          set +e
          warp-cli --accept-tos registration token "''${token_url}" 2>&1
          echo "$?" >&2
        )"

        reg_show="$(warp-cli --accept-tos registration show 2>/dev/null || true)"
        org_now="$(warp-cli --accept-tos registration organization 2>/dev/null || true)"

        if [[ -z "$reg_show" || "$org_now" != "$org" ]] || ! grep -q "Account type: Team" <<<"$reg_show"; then
          clean_system_registration
          restart_warp_daemon
          echo "Token callback failed (token is one-time; restart enrollment)." >&2
          echo "Details: ''${token_err}" >&2
          exit 1
        fi
        warp-cli --accept-tos connect >/dev/null

        echo
        warp-cli --accept-tos registration show || true
        warp-cli --accept-tos status || true

        echo
        curl -fsS https://www.cloudflare.com/cdn-cgi/trace | grep -E '^(warp=|gateway=|ip=|loc=|colo=)' || true
      '';
    })
    (pkgs.writeShellApplication {
      name = "warp-status";
      runtimeInputs = [
        pkgs.cloudflare-warp
        pkgs.curl
        pkgs.gnugrep
        pkgs.jq
      ];
      text = ''
        set -euo pipefail

        warp-cli --accept-tos status || true
        echo
        warp-cli --accept-tos -j status | jq . || true
        echo
        warp-cli --accept-tos registration organization || true
        echo
        curl -fsS https://www.cloudflare.com/cdn-cgi/trace | grep -E '^(warp=|gateway=|ip=|loc=|colo=)' || true
      '';
    })
    pkgs.tailscale
    (pkgs.writeShellApplication {
      name = "warp-fix";
      runtimeInputs = [
        pkgs.cloudflare-warp
      ];
      text = ''
        set -euo pipefail
        echo "Applying WARP fixes..."
        
        # Disconnect to allow configuration
        warp-cli --accept-tos disconnect || true
        
        # Exclude DNS servers from the tunnel to prevent bootstrap loops
        # Using newer 'tunnel ip add' syntax
        echo "Adding excluded routes for DNS..."
        warp-cli --accept-tos tunnel ip add 1.1.1.1 || true
        warp-cli --accept-tos tunnel ip add 1.0.0.1 || true

        # Disable connectivity checks to bypass "PerformingConnectivityChecks" hang
        echo "Disabling internal connectivity checks..."
        warp-cli --accept-tos debug connectivity-check disable || true
        
        # Reconnect
        echo "Reconnecting..."
        warp-cli --accept-tos connect || true
        
        echo "Done. Run 'warp-status' to check connectivity."
      '';
    })
    (pkgs.writeShellApplication {
      name = "warp-connected";
      runtimeInputs = [
        pkgs.cloudflare-warp
        pkgs.curl
        pkgs.gnugrep
        pkgs.jq
      ];
      text = ''
        set -euo pipefail

        require_gateway=0
        if [[ "''${1:-}" == "--require-gateway" ]]; then
          require_gateway=1
        elif [[ -n "''${1:-}" ]]; then
          echo "Usage: warp-connected [--require-gateway]" >&2
          exit 2
        fi

        status_json="$(warp-cli --accept-tos -j status 2>/dev/null || true)"
        status="$(jq -r '.status // empty' <<<"$status_json" 2>/dev/null || true)"

        if [[ "$status" != "Connected" && "$status" != "Connecting" ]]; then
          echo "WARP not connected (status=$status)" >&2
          exit 1
        fi

        trace="$(curl -fsS https://www.cloudflare.com/cdn-cgi/trace)"
        warp="$(grep -E '^warp=' <<<"$trace" | cut -d= -f2 || true)"
        gateway="$(grep -E '^gateway=' <<<"$trace" | cut -d= -f2 || true)"

        if [[ "$warp" != "on" ]]; then
          echo "Trace indicates WARP is off (warp=$warp)" >&2
          exit 1
        fi

        if [[ "$require_gateway" -eq 1 && "$gateway" != "on" ]]; then
          echo "Trace indicates Gateway is off (gateway=$gateway)" >&2
          exit 1
        fi

        echo "ok"
      '';
    })
  ];

  networking = {
    useDHCP = false;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      dns = "systemd-resolved";
    };

    # Force iptables legacy backend for WARP compatibility
    nftables.enable = false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    firewall = {
      checkReversePath = false;
      trustedInterfaces = [
        "CloudflareWARP"
        tailscaleInterface
        "docker0"
      ];
      allowedTCPPorts = [
        22
        3000
      ];
      allowedUDPPorts = [
        1701
        500
        4500
        # Tailscale
        config.services.tailscale.port
      ];
    };

    extraHosts = ''
      192.168.0.189 dante
      192.168.0.121 vergil
    '';
  };

  # consider disabling if conflicts with WARP
  # networking.wg-quick.interfaces = {
  #   wg0.configFile = config.age.secrets.wg0_conf.path;
  # };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = lib.mkForce false;

      cloudflare-warp = {
        after = [
          "NetworkManager.service"
          "systemd-resolved.service"
        ];
        wants = [
          "NetworkManager.service"
          "systemd-resolved.service"
        ];
      };

      # Tailscale can take over system DNS (MagicDNS/admin DNS), which is great
      # normally, but in a dual-VPN setup (WARP + Tailscale) it can look like the
      # internet "dies" when DNS starts pointing at Tailscale's resolver while the
      # tunnel is still coming up (or when WARP's firewall rules interfere).
      #
      # Keep the system's DNS stable (systemd-resolved + static nameservers),
      # but still keep MagicDNS working via split DNS on the Tailscale link.
      tailscale-preferences = lib.mkIf config.services.tailscale.enable {
        description = "Apply safe Tailscale preferences (avoid DNS takeover)";
        after = [
          "tailscaled.service"
          "network-online.target"
          "systemd-resolved.service"
        ];
        wants = [
          "tailscaled.service"
          "network-online.target"
        ];
        serviceConfig = {
          Type = "oneshot";
        };
        path = [
          config.services.tailscale.package
          pkgs.jq
          pkgs.systemd
        ];
        script = ''
          set -euo pipefail

          # Retry loop helper
          wait_for() {
            local limit="$1"
            local interval="1"
            local count=0
            shift
            while [[ $count -lt $limit ]]; do
              if "$@"; then
                return 0
              fi
              sleep "$interval"
              count=$((count + interval))
            done
            return 1
          }

          check_tailscale_running() {
            state="$(
              tailscale status --json --peers=false 2>/dev/null \
                | jq -r '.BackendState // empty' \
                || true
            )"
            [[ "$state" == "Running" ]]
          }

          # 1. Wait for Tailscale to be fully connected (up to 10s)
          # Use a short timeout so we don't block for long if it's intentionally stopped.
          if ! wait_for 10 check_tailscale_running; then
            echo "Tailscale not running (state!=Running) after 10s; skipping preference sync."
            exit 0
          fi

          # Prevent Tailscale from rewriting system DNS. Re-enable explicitly with:
          #   sudo tailscale set --accept-dns=true
          # Also allow LAN access to ensure local Docker subnets (172.17.x.x, etc) are not
          # routed into the tunnel when using an Exit Node.
          tailscale set --accept-dns=false --exit-node-allow-lan-access=true

          # Keep MagicDNS working without letting Tailscale take over global DNS.
          magic_suffix="$(
            tailscale status --json --peers=false 2>/dev/null \
              | jq -r '.MagicDNSSuffix // empty' \
              || true
          )"

          if [[ -z "$magic_suffix" ]]; then
            resolvectl revert ${tailscaleInterfaceArg} >/dev/null 2>&1 || true
            exit 0
          fi

          check_resolved_link() {
            resolvectl status ${tailscaleInterfaceArg} >/dev/null 2>&1
          }

          # 2. Wait for systemd-resolved to see the interface (up to 5s)
          if ! wait_for 5 check_resolved_link; then
            echo "systemd-resolved has no link ${tailscaleInterface} after 5s; skipping MagicDNS config."
            exit 0
          fi

          resolvectl dns ${tailscaleInterfaceArg} 100.100.100.100
          resolvectl domain ${tailscaleInterfaceArg} "$magic_suffix"
          resolvectl default-route ${tailscaleInterfaceArg} false
        '';
      };
    };

    timers.tailscale-preferences = lib.mkIf config.services.tailscale.enable {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "30s";
        OnUnitActiveSec = "1m";
        Unit = "tailscale-preferences.service";
      };
    };
  };

  virtualisation.docker = {
    rootless.daemon.settings = {
      mtu = 1280;
    };
    daemon.settings = {
      mtu = 1280;
    };
  };

  networking.networkmanager.unmanaged = [
    "CloudflareWARP"
    tailscaleInterface
  ];
}
