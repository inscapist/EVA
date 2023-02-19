{ config, pkgs, modulesPath, ... }: {
  imports = [
    ../../devil-arms/nix.nix
    ./optimization.nix
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  # disabledModules = [
  #   ../../devil-arms/fonts.nix
  #   ../../devil-arms/locales.nix
  # ];

  # use latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  networking = {
    wireless.enable = false;
    networkmanager.enable = true;
  };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtsjUN63tlgndK6fx+hHPVo7rhncnIb+Y6A5ftx3vSY sparda"
  ];

  environment = with pkgs; {
    variables = { EDITOR = "hx"; };
    systemPackages = let
      party = writeShellScriptBin "party" ''
        set -euxo pipefail

        # === config starts ===
        read -sp 'LUKS passphrase: ' passphrase
        hostname=vergil
        diskdev=/dev/nvme0n1 # check with lsblk
        bootpart=/dev/nvme0n1p1 # check with lsblk
        rootpart=/dev/nvme0n1p2 # check with lsblk

        # === LVM on LUKS2 starts ===
        # partition disk to the standard "EFI:Linux" layout
        sgdisk -o -g -n 1::+550M -t 1:ef00 -n 2:: -t 2:8300 $diskdev

        # format partition into a LUKS container
        echo $passphrase | cryptsetup luksFormat $rootpart --type luks2

        # open/unlock the LUKS container to /dev/mapper/nixcontainer
        echo $passphrase | cryptsetup luksOpen $rootpart nixcontainer

        # initialize physical volume "nixcontainer"
        pvcreate /dev/mapper/nixcontainer

        # create volume group named "vg" at /dev/vg
        vgcreate vg /dev/mapper/nixcontainer

        # create a logical volume named "nixos" at /dev/vg/nixos
        lvcreate -l '100%FREE' -n nixos vg

        mkfs.fat -n boot $bootpart
        mkfs.ext4 -L nixos /dev/vg/nixos

        # === mount for installation ===
        mount /dev/vg/nixos /mnt
        mkdir /mnt/boot
        mount $bootpart /mnt/boot

        # === actual installation ===
        nixos-generate-config --root /mnt
      '';
      flaky = writeShellScriptBin "flaky" ''
        cd /mnt/etc/nixos
        git clone https://github.com/sagittaros/EVA.git
        cd EVA
        nixos-install --flake .#vergil
      '';
    in [ party flaky ] ++ [ git tig lazygit helix curl which tree ];
  };
}
