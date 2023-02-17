# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, defaultUser, ... }:

{
  imports = [ ./hardware-configuration.nix ./optimization.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices = {
    nixcontainer = {
      # look for it by running `ls -l /dev/disk/by-uuid` and find the one that points to:
      #   /nvme0n1p2
      device = "/dev/disk/by-uuid/c2375d3b-1dc8-46db-a41b-773c633ce373";
      preLVM = true;
      allowDiscards = true;
    };
  };

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
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = defaultUser;
    # gvfs.enable = true;
    openssh = { enable = true; };
  };

  programs.zsh.enable = true;

  environment = {
    variables = { EDITOR = "hx"; };
    systemPackages = with pkgs;
      let
        clis = [ which bat curl wget exa fd fzf tree ripgrep jq fx ]
          ++ [ git tig lazygit ]
          ++ [ irssi httpie tokei zip tealdeer helix hexyl unrar ]
          ++ [ dua duf glances htop btop iotop ]
          ++ [ graphviz jq tesseract poppler_utils gdb ]
          ++ [ tcpdump inetutils dig socat netcat ];
        others = [ duplicity cbonsai slack obsidian zathura ];
        browsers = [ brave firefox ];
        os = [ lxappearance gthumb maim pavucontrol ranger ];
      in clis ++ others ++ browsers ++ os;
  };

  system = {
    stateVersion = "23.05";
    autoUpgrade.enable = true;
  };
}
