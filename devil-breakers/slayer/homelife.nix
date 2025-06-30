{ pkgs, ... }:

{
  # services.easyeffects.enable = true;

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

    spotify
    jamesdsp
  ];
}
