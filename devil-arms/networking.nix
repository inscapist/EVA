{
  config,
  lib,
  inputs,
  ...
}:
{
  services.tailscale.enable = true;
  services.openssh.enable = true;

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
        # Add Cloudflare WARP ports
        2408
      ];
      allowedUDPPorts = [
        # Add Cloudflare WARP ports
        2408
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

  services.resolved = {
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
  services.cloudflare-warp = {
    enable = false;
  };

  # networking.networkmanager.unmanaged = [ "CloudflareWARP" ];
}
