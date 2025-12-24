{
  config,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ../../devil-arms/os.nix
    ./optimization.nix
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

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
    variables = {
      EDITOR = "hx";
    };
    systemPackages =
      let

        party = writeShellScriptBin "party" ''
          set -euo pipefail

          diskdev=/dev/vda

          # Partitioning
          sgdisk -o -g -n 1::+550M -t 1:ef00 -n 2:: -t 2:8300 $diskdev

          # Formatting
          mkfs.fat -n boot ''${diskdev}1
          mkfs.ext4 -L nixos ''${diskdev}2

          # Pre-Installation
          mount ''${diskdev}2 /mnt
          mkdir -p /mnt/boot
          mount ''${diskdev}1 /mnt/boot

          # Generate/Copy Configuration
          nixos-generate-config --root /mnt
        '';

        flaky = writeShellScriptBin "flaky" ''
          set -euxo pipefail

          cd /mnt/etc/nixos
          git clone https://github.com/sagittaros/EVA.git
          cd EVA
          nixos-install --flake .#dante
        '';
      in
      [
        party
        flaky
      ]
      ++ [
        gptfdisk
        dosfstools
        e2fsprogs
        git
        tig
        lazygit
        helix
        curl
        which
        tree
      ];
  };
}
