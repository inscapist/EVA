{
  services.openssh.enable = true;

  networking = {
    # inherit hostName;
    useDHCP = false;
    # networking.interfaces.wlp0s20f3.useDHCP = true;
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
  };
}
