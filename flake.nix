{
  description = "My NixOS configuration - codenamed EVA";

  outputs = inputs@{ self, nixpkgs, flake-utils, emacs-overlay, emacs29, ... }:
    let
      system = "x86_64-linux";
      mods = [ ./devil-arms ./devil-breakers ];
      dt = import ./devil-triggers nixpkgs.lib;
      sdt = import ./sin-devil-triggers;
      orbs = import ./orbs inputs;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          emacs-overlay.overlay
          orbs.fontDankMono
          # orbs.polyglot
        ];
      };
      specialArgs = {
        inherit system pkgs inputs dt sdt;
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

    } // flake-utils.lib.eachDefaultSystem (system:
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
    flake-utils.url = "github:numtide/flake-utils";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      # TODO remove ref once the branch is more stable
      url = "github:hyprwm/Hyprland?ref=v0.21.0beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs29 = {
      url = "github:emacs-mirror/emacs/emacs-29";
      flake = false;
    };
    doom = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
