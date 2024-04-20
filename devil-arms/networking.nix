{ config, lib, ... }:

{
  services.tailscale.enable = true;
  services.openssh.enable = true;

  networking = {
    useDHCP = false;
    networkmanager = {
      dhcp = "dhcpcd";
      enable = true;
      wifi.backend = "iwd";
      dns = "systemd-resolved";
    };

    nameservers = [
      "45.90.28.0#2977d3.dns.nextdns.io"
      "2a07:a8c0::#2977d3.dns.nextdns.io"
      "45.90.30.0#2977d3.dns.nextdns.io"
      "2a07:a8c1::#2977d3.dns.nextdns.io"
    ];

    firewall = {
      allowedTCPPorts = [ 22 ];
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
