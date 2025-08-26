{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # office
    slack
    signal-desktop
    obsidian
    libreoffice-fresh

    # compression
    unrar
    unar
    libsForQt5.ark

    # pdf viwers
    # evince
    # mate.atril

    # authentication
    _1password-gui
    _1password-cli
  ];
}
