{ pkgs, ... }:

{
  programs.go.enable = true;

  home.packages = with pkgs; [
    #-- Languages --#
    yarn
    python39
    clojure
    leiningen
    #-- LSP --#
    nil
    sumneko-lua-language-server
    gopls
    pyright
    clojure-lsp
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
}
