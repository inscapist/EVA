{ user, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    permittedInsecurePackages = [
      "beekeeper-studio-5.1.5"
      "electron-21.4.0"
      "openssl-1.1.1w"
    ];
  };

  programs.nix-ld.enable = true;

  nix = {
    optimise.automatic = true;
    # https://nixos.wiki/wiki/Storage_optimization
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 10d";
    };
    settings = {
      trusted-users = [
        "root"
        user
      ];

      # allowed-users = [ "@wheel" ];
      # trusted-users = [ "root" "@wheel" ];
      # system-features = [ "recursive-nix" ];

      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-config.cachix.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;
    };
  };
}
