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
    # nodePackages_latest.firebase-tools
    python311 # install pip with `python -m ensurepip --upgrade`
    clojure
    leiningen
    rustup
    devenv
    #-- OCaml --#
    ocaml
    opam
    dune_3
    ocamlPackages.utop
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocp-indent
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
    dockerfile-language-server
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
    # vscode
    code-cursor
    # windsurf
    # postman
    pwgen
    # zed-editor
    # jan
    quarto
    texlive.combined.scheme-full

    perf
  ];
}
