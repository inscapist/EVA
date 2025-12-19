{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mpv
    gthumb
    asciinema
    xfce.thunar
    exiftool
    file
    zoxide
    ffmpegthumbnailer
    poppler
  ];
}
