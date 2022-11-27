# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  hostName = "vergil";
  diskId = "/dev/disk/by-uuid/7d410c1c-20fd-407e-b4e9-bef439090522";
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

  users.users.${hostName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.zsh;
  };
}
