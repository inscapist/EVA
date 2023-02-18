{
  description = "My NixOS configuration - codenamed EVA";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, home-manager, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      common = [
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        ./devil-arms
        ./devil-breakers
      ];
      defaultUser = "xi";
    in {

      # --------------------------------------------------------
      # My systems
      # ========================================================

      # Primary Driver - XPS 9520
      nixosConfigurations.vergil = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs defaultUser; };
        modules = [ ./nephilims/vergil ] ++ common;
      };

      # Dante (Qemu on Alienware)
      nixosConfigurations.dante = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs defaultUser; };
        modules = [ ./nephilims/dante ./devil-arms/nix.nix ]; # ++ common;
      };

      # --------------------------------------------------------
      # Installers
      # ========================================================

      # Vergil Installer
      nixosConfigurations.vergilInstaller = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nephilims/vergil/installer.nix ];
      };

      # Dante Installer
      nixosConfigurations.danteInstaller = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nephilims/dante/installer.nix ];
      };

    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default =
          import ./devil-triggers/dev-shell.nix { inherit pkgs; };
        formatter = pkgs.nixpkgs-fmt;
      });
}
