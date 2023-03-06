{ pkgs, ... }:

{
  home.packages = with pkgs; [
    slack
    signal-desktop-beta
    obsidian
    libreoffice-fresh

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
