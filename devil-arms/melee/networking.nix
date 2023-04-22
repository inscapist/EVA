{ config, lib, ... }:

with builtins;
with lib;
let
  blocklist = fetchurl {
    url =
      "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts";
    sha256 = "02x2i5k78a28g07l7fbfl8i04w9s06q05qg9w2rvpcg6i8ihn02b";
  };
in {
  services.openssh.enable = true;

  networking = {
    useDHCP = false;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";

      # https://www.reddit.com/r/archlinux/comments/xf4z2m/thoughts_on_systemdresolved_vs_dnsmasq/
      # dns = "systemd-resolved";
    };

    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    networkmanager.insertNameservers = [ "1.1.1.1" "8.8.8.8" ];

    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };

    extraHosts = ''
      192.168.0.189 dante
      192.168.0.121 vergil

      ${(readFile blocklist)}
    '';

  };

  # my wireguard client configs
  networking.wg-quick.interfaces = {
    # systemctl start wg-quick-wg0
    wg0.configFile = config.age.secrets.wg0_conf.path;
  };

  # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1473408913
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  # services.resolved = {
  #   enable = true;
  #   dnssec = "allow-downgrade";
  #   fallbackDns =
  #     [ "1.1.1.1" "2606:4700:4700::1111" "8.8.8.8" "2001:4860:4860::8844" ];
  #   llmnr = "true";
  #   extraConfig = ''
  #     Domains=~.
  #     MulticastDNS=true
  #   '';
  # };
}
