{ pkgs, ... }:

let
  pythonDevEnv =
    pkgs.python311.withPackages (ps: [
      ps.pip
      ps.pandas
      ps.openpyxl
    ]);

  kubectlKrewPlugin = pkgs.writeShellScriptBin "kubectl-krew" ''
    exec ${pkgs.krew}/bin/krew "$@"
  '';

  kubectlCtxPlugin = pkgs.writeShellScriptBin "kubectl-ctx" ''
    exec ${pkgs.kubectx}/bin/kubectx "$@"
  '';

  kubectlNsPlugin = pkgs.writeShellScriptBin "kubectl-ns" ''
    exec ${pkgs.kubectx}/bin/kubens "$@"
  '';
in
{

  programs = {
    go.enable = true;
    java.enable = true;
  };

  home.packages = with pkgs; [
    #-- devops/tools --#
    ngrok
    overops
    vagrant
    openssl
    kubectl
    kubectx
    kubernetes-helm
    krew
    kubectlKrewPlugin
    kubectlCtxPlugin
    kubectlNsPlugin
    kapp
    stern
    #-- Languages --#
    uv
    yarn
    nodejs
    # nodePackages_latest.firebase-tools
    pythonDevEnv
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
    lua-language-server
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
    timg
    libcaca
    # rustdesk
    # libz
    beekeeper-studio
    # mongodb-compass
    # vscode
    code-cursor
    cursor-cli
    antigravity
    kiro-fhs
    # windsurf
    # postman

    d2
    structurizr-cli
    pwgen
    # zed-editor
    # jan
    # quarto
    texlive.combined.scheme-full
    perlPackages.LaTeXML
    python313Packages.markitdown
    calibre
    mupdf
    dos2unix
    flyctl

    perf
  ];
}
