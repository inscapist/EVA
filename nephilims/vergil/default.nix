# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  lib,
  config,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./optimization.nix
  ];

  system = {
    stateVersion = "23.11";
    autoUpgrade.enable = true;
  };

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.initrd.luks.devices = {
    nixcontainer = {
      # to use uuid, look for it by running `ls -l /dev/disk/by-uuid` and find the one that points to `/nvme0n1p2`
      device = "/dev/nvme0n1p2";
      preLVM = true;
      allowDiscards = true;
    };
  };

  programs.zsh.enable = true;

  security.pam.loginLimits = [
    {
      domain = "@realtime";
      type = "-";
      item = "rtprio";
      value = "99";
    }
    {
      domain = "@realtime";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

  users.groups.realtime = {};

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "realtime"
    ];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.userpass.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtsjUN63tlgndK6fx+hHPVo7rhncnIb+Y6A5ftx3vSY sparda"
    ];
  };

  services = {
    getty.autologinUser = user;
    openssh.enable = true;
  };
}
