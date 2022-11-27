{ config, pkgs, ... }: {
  system.stateVersion = "22.11";

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true; # TODO reevaluate this
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
