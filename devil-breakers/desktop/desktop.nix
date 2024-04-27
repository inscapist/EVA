{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";
    extraConfig = {
      font = "MonaspiceRn Nerd Font 20";
    };
  };

  home.packages = with pkgs; [
    xorg.xset
    xorg.setxkbmap
    xorg.xinit
    xorg.xrandr
    xorg.xrdb
    xorg.xprop
    xorg.xeyes
    xorg.xlsclients
    xorg.xwininfo

    arandr
    maim
    xclip
    xsel
  ];

  home.file.".background.png".source = ./background.png;
}
