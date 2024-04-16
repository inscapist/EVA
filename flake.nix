{
  description = "My NixOS configuration - codenamed EVA";

  outputs = inputs@{ self, nixpkgs, fu, ... }:
    let
      system = "x86_64-linux";
      mods = [ ./devil-arms ./devil-breakers ./sins ];
      dt = import ./devil-triggers nixpkgs.lib;
      orbs = import ./orbs inputs;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          orbs.fontDankMono
          # orbs.polyglot
        ];
      };
      specialArgs = {
        inherit system pkgs inputs dt;
        user = "xi";
      };
    in {
      # --------------------------------------------------------
      # My systems
      # ========================================================

      # //-- Primary Driver - XPS 9520 --//
      nixosConfigurations.vergil = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./nephilims/vergil ] ++ mods;
      };

      # //-- Dante - Qemu --//
      nixosConfigurations.dante = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./nephilims/dante ] ++ mods;
      };

      # --------------------------------------------------------
      # Installers
      # ========================================================

      # //-- Vergil Installer --//
      nixosConfigurations.vergilInstaller = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./nephilims/vergil/installer.nix ];
      };

      # //-- Dante Installer on Qemu (make sure to change from bios to UEFI) --//
      # nix build .#nixosConfigurations.danteInstaller.config.system.build.isoImage -o dante-iso
      # find the thumbdrive using `lsblk` and replace `/dev/sdb` below
      # sudo dd if=dante-iso/iso/TAB.iso of=/dev/sdb status=progress
      nixosConfigurations.danteInstaller = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [ ./nephilims/dante/installer.nix ];
      };

    } // fu.lib.eachDefaultSystem (system:
      # --------------------------------------------------------
      # Dev shell
      # ========================================================
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = import ./dev-shell.nix { inherit pkgs; };
        formatter = pkgs.nixpkgs-fmt;
      });

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    fu.url = "github:numtide/flake-utils";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "fu";
    };
  };
}
