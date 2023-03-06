{
  imports = [
    # pfft!
    ./firearms/fonts.nix
    ./firearms/privacy.nix
    ./firearms/tools.nix
    ./firearms/wayland.nix

    # anyone can use it, only a few truly master them
    ./melee/bluetooth.nix
    ./melee/networking.nix
    ./melee/os.nix
    ./melee/power.nix
    ./melee/security.nix
    ./melee/sound.nix
    ./melee/virtualization.nix
  ];
}
