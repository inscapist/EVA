{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #-- recreation --#
    mindustry-wayland
    openra
    warzone2100
    zdoom
    flare
    godot

    #-- education --#
    celestia
    stellarium
    octave
  ];
}
