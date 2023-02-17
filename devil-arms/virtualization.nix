{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ virt-manager spice-gtk swtpm ];
  security.polkit.enable = true;
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd = {
      autoPrune.enable = true;
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = with pkgs; [ OVMFFull.fd ];
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
