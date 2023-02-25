{ eww, system, ... }:

{
  imports = [ ./fufexan-eww ./fufexan-theme ];

  programs.eww-hyprland = {
    enable = true;
    package = eww.packages.${system}.eww-wayland;
  };
}
