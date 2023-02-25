lib:

let
  nico = import ../nico lib;
  colors = import ./colors.nix;
in {
  # -> #RRGGBB
  hexColors = lib.mapAttrs (_: nico.colorlib.hex) colors;

  # -> rgba(,,,) colors (css)
  rgbaColors = lib.mapAttrs (_: nico.colorlib.rgba) colors;
}
