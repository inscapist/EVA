{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #-- recreation --#
    mindustry-wayland
    openra
    warzone2100
    zdoom
    flare

    #-- education --#
    celestia
    stellarium
    octave
  ];
}
