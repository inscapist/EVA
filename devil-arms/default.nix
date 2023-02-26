{
  imports = [
    # pfft!
    ./firearms/fonts.nix
    ./firearms/locales.nix
    ./firearms/tools.nix
    ./firearms/wayland.nix

    # anyone can use it, only a few truly master them
    ./melee/base.nix
    ./melee/bluetooth.nix
    ./melee/networking.nix
    ./melee/power.nix
    ./melee/security.nix
    ./melee/sound.nix
    ./melee/virtualization.nix
  ];
}
