{ pkgs }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    nixfmt-rfc-style # from serokell folks, I prefer it
    nil
    statix
    manix
  ];

  shellHook = ''
    echo "Devil May Cry"
  '';
}
