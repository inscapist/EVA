{ pkgs, ... }: {
  programs = { rofi.enable = true; };

  home.packages = with pkgs; [
    xorg.xset
    xorg.setxkbmap
    xorg.xinit
    xorg.xbacklight
    xorg.xrandr
    xorg.xrdb
    xorg.xprop

    arandr
    maim
    xclip
  ];
}
