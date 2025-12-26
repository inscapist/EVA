{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mpv
    gthumb
    asciinema
    nemo-with-extensions
    exiftool
    file
    zoxide
    ffmpegthumbnailer
    poppler
  ];
}
