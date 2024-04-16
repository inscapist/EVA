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
    kubectl
    krew
    azuredatastudio
    android-studio
    #-- Languages --#
    yarn
    nodejs
    nodePackages_latest.firebase-tools
    python39 # install pip with `python -m ensurepip --upgrade`
    clojure
    leiningen
    rustup
    #-- LSP --#
    nil
    sumneko-lua-language-server
    gopls
    pyright
    clojure-lsp
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
    nixfmt-rfc-style
    beautysh
    nodePackages.prettier
    #-- Misc --#
    lldb
    rustdesk
  ];
}
