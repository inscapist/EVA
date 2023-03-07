{ pkgs, ... }:

{
  programs = {
    go.enable = true;
    java.enable = true;
  };

  home.packages = with pkgs; [
    #-- devops/tools --#
    vagrant
    openssl
    flyctl
    kubectl
    krew
    kubectx
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
    haskell-language-server
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    texlab
    #-- Linters --#
    hlint
    shellcheck
    #-- Formatters --#
    black
    nixfmt
    rustfmt
    beautysh
    nodePackages.prettier
    #-- Debug --#
    lldb
    #-- Others --#
    cmatrix
    prismlauncher
    freetube
    protontricks
  ];
}
