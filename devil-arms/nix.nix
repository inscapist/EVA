{ config, pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true; # TODO reevaluate this
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
