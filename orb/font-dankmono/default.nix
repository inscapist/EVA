{ pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation {
  name = "dank-mono";
  dontConfigure = true;
  src = ./dank-mono.zip;
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R "$src/Dank Mono Italic.otf" $out/share/fonts/opentype/
    cp -R "$src/Dank Mono Regular.otf" $out/share/fonts/opentype/
  '';
  meta = { description = "Dank Mono font"; };
}
