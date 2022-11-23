{
  description = "My NixOS configuration - codename EVA";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, agenix, flake-utils, ... }:
    let defaultSystem = "x86_64-linux";
    in {
      nixosConfigurations.vergil = nixpkgs.lib.nixosSystem {
        system = defaultSystem;
        modules = [ ./nephilims/vergil agenix.nixosModule ];
      };
    } // flake-utils.lib.eachSystem [ defaultSystem ] (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default =
          import ./devil-triggers/dev-shell.nix { inherit pkgs; };
        formatter = pkgs.nixfmt;
      });
}
