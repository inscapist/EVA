{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
    };
  };
  home = {
    packages = with pkgs; [
      #-- LSP --#
      nil
      sumneko-lua-language-server
      gopls
      pyright
      rust-analyzer
      tree-sitter
      #-- Formatters --#
      black
      nixfmt
      rustfmt
      beautysh
      nodePackages.prettier
      #-- Debug --#
      lldb
    ];
  };

  home.file.".config/nvim".source = ./nvim;
}
