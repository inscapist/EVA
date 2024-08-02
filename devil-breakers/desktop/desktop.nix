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
    arandr
    maim
    xclip
    xsel
  ];

  home.file.".background.png".source = ./wallpapers/ffxv.png;
}
