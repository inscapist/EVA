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

    #-- productivity --#
    calibre
    lsix
    xournalpp

    #-- others/vanity/fun? --#
    cmatrix
    cbonsai
    nyancat
  ];
}
