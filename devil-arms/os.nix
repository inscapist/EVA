{ user, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    permittedInsecurePackages = [
      "electron-21.4.0"
      "openssl-1.1.1w"
    ];
  };

  nix = {
    optimise.automatic = true;
    gc.automatic = true;
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
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
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
