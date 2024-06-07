{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #-- recreation --#
    # mindustry-wayland
    # openra
    # warzone2100
    # flare

    #-- education --#
    celestia
    stellarium
    octave

    #-- Others/vanity/fun? --#
    cmatrix
    cbonsai
    nyancat
    calibre
    lsix
  ];
}
