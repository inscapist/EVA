{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mpv
    gthumb
    imv
    feh
    asciinema
    xfce.thunar
    exiftool
    file
    zoxide
    ffmpegthumbnailer
    unar
    poppler
  ];
}
