{ user, pkgs, ... }:
{
  programs.nix-ld.enable = true;

  systemd.tmpfiles.rules = [
    "L+ /bin/bash - - - - ${pkgs.bashInteractive}/bin/bash"
  ];

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
        "https://nixpkgs-ruby.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-config.cachix.org-1:Vd6raEuldeIZpttVQfrUbLvXJHzzzkS0pezXCVVjDG4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-ruby.cachix.org-1:vrcdi50fTolOxWCZZkw0jakOnUI1T19oYJ+PRYdK4SM="
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
