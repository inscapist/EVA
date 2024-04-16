{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #-- recreation --#
    gthumb
    mindustry-wayland
    openra
    warzone2100
    zdoom
    flare

    #-- education --#
    celestia
    stellarium
    octave

    #-- Others/vanity/fun? --#
    cmatrix
    cbonsai
    dmidecode
  ];
}
