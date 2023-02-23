{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      initExtra = ''
        if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec Hyprland
        fi
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
  };
  home.file.".zshrc".source = ./zsh/zshrc;
}
