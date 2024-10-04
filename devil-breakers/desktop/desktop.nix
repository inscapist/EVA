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
    maim
    xclip
    xsel
  ];

  home.file.".background.png".source = ./wallpapers/ttm.png;
}
