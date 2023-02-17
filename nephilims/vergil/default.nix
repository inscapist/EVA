# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, defaultUser, ... }:

# look for it by running `ls -l /dev/disk/by-uuid` and find the one that points to:
#   /nvme0n1p2
let diskId = "/dev/disk/by-uuid/c2375d3b-1dc8-46db-a41b-773c633ce373";
in {
  imports = [ ./hardware-configuration.nix ./optimization.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices = {
    nixcontainer = {
      device = diskId;
      preLVM = true;
      allowDiscards = true;
    };
  };

  users.users.${defaultUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.05";
}
