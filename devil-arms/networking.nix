{ config, lib, ... }:
with builtins;
with lib;
let
in
# # nix-prefetch-url --type sha256 "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
# blocklist = fetchurl {
#   url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts";
#   sha256 = "1693g755vv26ffnxm2w73hz9w5hvgx7xn616sgjy8yjh34zi33j2";
# };
{
  services.tailscale.enable = true;
  services.openssh.enable = true;

  networking = {
    networkmanager = {
      enable = true;
      # wifi.backend = "iwd";
      dns = "systemd-resolved";
    };

    nameservers = [
      "45.90.28.0#2977d3.dns.nextdns.io"
      "2a07:a8c0::#2977d3.dns.nextdns.io"
      "45.90.30.0#2977d3.dns.nextdns.io"
      "2a07:a8c1::#2977d3.dns.nextdns.io"
    ];

    firewall = {
      allowedTCPPorts = [ 22 3000 ];
      allowedUDPPorts = [ ];
    };

    extraHosts = ''
      192.168.0.189 dante
      192.168.0.121 vergil
    '';
  };

  # my wireguard client configs
  networking.wg-quick.interfaces = {
    # systemctl start wg-quick-wg0
    wg0.configFile = config.age.secrets.wg0_conf.path;
  };

  # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1473408913
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
    dnsovertls = "true";
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
    '';
  };
}
