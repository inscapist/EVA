{ config, pkgs, modulesPath, ... }: {
  imports = [
    ./optimization.nix
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  disabledModules = [
    ../../devil-arms/fonts.nix
    ../../devil-arms/locales.nix
    ../../devil-arms/softwares.nix
  ];

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtsjUN63tlgndK6fx+hHPVo7rhncnIb+Y6A5ftx3vSY sparda"
  ];
}
