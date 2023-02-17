{
  description = "My NixOS configuration - codenamed EVA";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      defaultUser = "xi";
      commonModules = [ agenix.nixosModules.default ./devil-arms ];
    in {

      # Primary Driver - XPS 9520
      nixosConfigurations.vergil = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs defaultUser; };
        modules = [ ./nephilims/vergil ] ++ commonModules;
      };

      # Installer
      nixosConfigurations.vergilInstaller = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs defaultUser; };
        modules = [ ./nephilims/vergil/installer.nix ] ++ commonModules;
      };

    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default =
          import ./devil-triggers/dev-shell.nix { inherit pkgs; };
        formatter = pkgs.nixpkgs-fmt;
      });
}
