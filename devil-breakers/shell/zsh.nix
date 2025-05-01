{ ... }:
{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = false; # am handling it in zshrc
    };
  };
  home.file.".config/zsh/.zshrc".source = ./zsh/zshrc;
  home.file.".config/direnv/direnv.toml".source = ./zsh/direnv.toml;
}
