# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  hostName = "vergil";
  diskId = "/dev/disk/by-uuid/7d410c1c-20fd-407e-b4e9-bef439090522";
  timezone = "Asia/Singapore";
in {
  imports = [
    ./hardware-configuration.nix
    ./optimization.nix

    ../../devil-arms/bluetooth.nix
    ../../devil-arms/dev.nix
    ../../devil-arms/environment.nix
    ../../devil-arms/fonts.nix
    ../../devil-arms/nvidia.nix
    ../../devil-arms/sound.nix
    ../../devil-arms/wm.nix
    ../../devil-arms/xorg.nix
  ];

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

  networking = {
    inherit hostName;
    useDHCP = false;
    # networking.interfaces.wlp0s20f3.useDHCP = true;
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    firewall = {
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [ ];
    };
  };

  services.openssh.enable = true;

  time.timeZone = timezone;
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ rime ];
  };

  console = {
    # keyMap = "colemak";
  };

  users.users.${hostName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Nix section
  system.stateVersion = "22.11";
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
