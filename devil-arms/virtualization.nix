{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ virt-manager spice-gtk ];

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
    # spiceUSBRedirection.enable = true;
  };
}
