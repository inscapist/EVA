{ pkgs, ... }:

{
  programs = {
    go.enable = true;
    java.enable = true;
  };

  home.packages = with pkgs; [
    #-- devops/tools --#
    ngrok
    vagrant
    openssl
    kubectl
    kubernetes-helm
    krew
    kapp
    stern
    #-- Languages --#
    yarn
    nodejs
    nodePackages_latest.firebase-tools
    python311 # install pip with `python -m ensurepip --upgrade`
    clojure
    leiningen
    rustup
    devenv
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
    # texlab
    #-- Linters --#
    hlint
    shellcheck
    #-- Formatters --#
    black
    nixfmt-rfc-style
    beautysh
    nodePackages.prettier
    shfmt
    #-- Misc --#
    lldb
    # rustdesk
    # libz
    beekeeper-studio
    # mongodb-compass
    vscode
    postman
  ];
}
