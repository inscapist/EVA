{
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true; # TODO reevaluate this
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      # allowed-users = [ "@wheel" ];
      # trusted-users = [ "root" "@wheel" ];
      # system-features = [ "recursive-nix" ];
      substituters =
        [ "https://nix-config.cachix.org" "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];

    };
    optimise = {
      automatic = true;
      dates = "weekly";
    };
  };
}
