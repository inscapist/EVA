{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    nixfmt # from serokell folks, I prefer it
    nixpkgs-fmt
    rnix-lsp
    statix
    manix
  ];

  shellHook = ''
    echo "Devil May Cry"
  '';
}
