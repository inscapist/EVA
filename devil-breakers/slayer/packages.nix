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

    # authentication
    _1password-gui
    _1password
    authy

    # dev/ops
    flyctl
    kubectl
    krew
    kubectx
  ];
}
