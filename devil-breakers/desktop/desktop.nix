{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";
    extraConfig = {
      font = "MonaspiceRn Nerd Font 32";
    };
  };

  home.packages = with pkgs; [
    arandr
    feh
    maim
    xclip
    xsel
  ];

  home.file.".background.png".source = ./wallpapers/ninesols5.png;
}
