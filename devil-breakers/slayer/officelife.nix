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
    kdePackages.ark

    # pdf viwers
    # evince
    # mate.atril

    # authentication
    _1password-gui
    _1password-cli
  ];
}
