# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, defaultUser, ... }:

{
  imports = [ ./qemu-configuration.nix ./optimization.nix ];

  system = {
    stateVersion = "23.05";
    autoUpgrade.enable = true;
  };

  # use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  users.users.${defaultUser} = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "docker" "networkmanager" "libvirtd" "video" "audio" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtsjUN63tlgndK6fx+hHPVo7rhncnIb+Y6A5ftx3vSY sparda"
    ];
  };

  services = {
    getty.autologinUser = defaultUser;
    openssh = { enable = true; };
  };
}
