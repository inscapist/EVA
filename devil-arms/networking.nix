{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  services = {
    tailscale.enable = false;
    openssh.enable = true;
    resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      dnsovertls = "opportunistic";
      llmnr = "true";
      fallbackDns = [
        "45.90.28.0#2977d3.dns.nextdns.io"
        "2a07:a8c0::#2977d3.dns.nextdns.io"
        "45.90.30.0#2977d3.dns.nextdns.io"
        "2a07:a8c1::#2977d3.dns.nextdns.io"
      ];
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

        if [[ "$status" != "Connected" ]]; then
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

    # Use Cloudflare DNS as primary, with NextDNS as fallback
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "45.90.28.0#2977d3.dns.nextdns.io"
      "45.90.30.0#2977d3.dns.nextdns.io"
    ];

    firewall = {
      allowedTCPPorts = [
        22
        3000
      ];
      allowedUDPPorts = [
        1701
        500
        4500
      ];
    };

    extraHosts = ''
      192.168.0.189 dante
      192.168.0.121 vergil
      ${lib.readFile inputs.blocklist}
    '';
  };

  # consider disabling if conflicts with WARP
  networking.wg-quick.interfaces = {
    wg0.configFile = config.age.secrets.wg0_conf.path;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  virtualisation.docker = {
    rootless.daemon.settings = {
      dns = [
        "1.1.1.1"
        "9.9.9.9"
      ];
    };
    daemon.settings = {
      dns = [
        "1.1.1.1"
        "9.9.9.9"
      ];
    };
  };

  # networking.networkmanager.unmanaged = [ "CloudflareWARP" ];
}
