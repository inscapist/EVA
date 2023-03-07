{ pkgs, ... }:

{
  programs = {
    go.enable = true;
    java.enable = true;
  };

  home.packages = with pkgs; [
    #-- tools --#
    vagrant
    #-- Languages --#
    yarn
    nodejs
    nodePackages_latest.firebase-tools
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
