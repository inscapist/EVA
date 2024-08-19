{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #-- education --#
    # celestia
    # stellarium
    # octave

    #-- productivity --#
    # calibre
    # lsix

    #-- others/vanity/fun? --#
    # cmatrix
    # cbonsai
    # nyancat

    discord
  ];
}
