{ pkgs, ... }:
{

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
