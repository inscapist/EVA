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
    prismlauncher

    #-- education --#
    celestia
    stellarium
    octave

    #-- Others/vanity/fun? --#
    cmatrix
    cbonsai
  ];
}
