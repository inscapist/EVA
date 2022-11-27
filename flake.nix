{
  description = "My NixOS configuration - codename EVA";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    flake-utils.url = "github:numtide/flake-utils";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, agenix, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      commonModules = [ agenix.nixosModule ./devil-arms ];
    in {
      nixosConfigurations.vergil = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nephilims/vergil ] ++ commonModules;
      };

      # NOTE usage
      # nix build .#nixosConfigurations.vergilInstaller.config.system.build.isoImage
      # `lsblk` to find the flashdrive
      # dd if=result/iso/_.iso of=/dev/sd_ status=progress
      nixosConfigurations.vergilInstaller = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nephilims/vergil/installer.nix ] ++ commonModules;
      };

    } // flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" ] (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default =
          import ./devil-triggers/dev-shell.nix { inherit pkgs; };
        formatter = pkgs.nixfmt;
      });
}
