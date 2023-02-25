lib:

let
  nico = import ./nico lib;
  palette = import ./theme/palette.nix;
in {
  theme = {
    # -> #RRGGBB
    colors = lib.mapAttrs (_: nico.colorlib.hex) palette;

    # -> rgba(,,,) colors (css)
    cssColors = lib.mapAttrs (_: nico.colorlib.rgba) palette;
  };
}
