{ stdenvNoCC, unzip, ... }:

# https://gist.github.com/camtauxe/a1e475e11cd8a23407fd1714c87a3ae1
let font = "dank-mono";
in stdenvNoCC.mkDerivation {
  name = font;
  dontConfigure = true;

  nativeBuildInputs = [ unzip ];
  src = ./dank-mono.zip;

  installPhase = ''
    rm -rf __MACOSX/
    DEST="$out/share/fonts/${font}"
    mkdir -p "$DEST"
    find . \( -name '*.ttf' -o -name '*.otf' \) -print0 | xargs -0 cp -t "$DEST"

    # mkdir -p $out/share/fonts/opentype
    # cp -R "$src/dank-mono-italic.otf" $out/share/fonts/opentype/
    # cp -R "$src/dank-mono-regular.otf" $out/share/fonts/opentype/
  '';

  meta = { description = "Dank Mono font"; };
}
