{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # office
    slack
    signal-desktop-beta
    obsidian
    libreoffice-fresh
    teamviewer
    zoom-us
    filezilla
    neovim-qt
    unar

    # pdf viwers
    # evince
    # mate.atril

    # authentication
    _1password-gui
    _1password
    authy
  ];
}
