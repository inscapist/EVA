{ pkgs, defaultUser, ... }: {
  virtualisation = {
    docker = {
      autoPrune.enable = true;
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = with pkgs; [ OVMFFull.fd ];
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [ virt-manager docker-compose ];

  users.groups.docker.members = [ defaultUser ];
  users.groups.libvirtd.members = [ defaultUser ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
