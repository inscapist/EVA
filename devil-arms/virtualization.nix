{ pkgs, user, ... }:
{
  virtualisation = {
    docker = {
      autoPrune.enable = true;
      enable = false;
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    docker-compose
  ];

  users.groups.docker.members = [ user ];
  users.groups.libvirtd.members = [ user ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
