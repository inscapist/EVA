{
  services.openssh.enable = true;

  networking = {
    useDHCP = false;
    # networking.interfaces.wlp0s20f3.useDHCP = true;
    networkmanager = {
      enable = true;
      # https://www.reddit.com/r/archlinux/comments/xf4z2m/thoughts_on_systemdresolved_vs_dnsmasq/
      dns = "systemd-resolved";
    };
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    fallbackDns =
      [ "1.1.1.1" "2606:4700:4700::1111" "8.8.8.8" "2001:4860:4860::8844" ];
    llmnr = "true";
    extraConfig = ''
      Domains=~.
      MulticastDNS=true
    '';
  };
}
