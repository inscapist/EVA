{ pkgs, yazi, ... }:
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
    superfile
  ];
  programs = {
    yazi = {
      enable = true;
      package = yazi.packages.${pkgs.system}.default;
      enableZshIntegration = true;
    };
  };
}
