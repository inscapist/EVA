{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      initExtra = ''
        if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec Hyprland
        fi
      '';
    };
  };
  home.file.".zshrc".source = ./zsh/zshrc;
}
