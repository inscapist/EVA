{ user, lib, ... }:

with lib; {
  console.useXkbConfig = true;

  time.timeZone = mkDefault "Asia/Singapore";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    permittedInsecurePackages = [ "electron-21.4.0" ];
  };

  nix = {
    settings = {
      trusted-users = [ "root" user ];
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
    optimise = { automatic = true; };
  };
}
