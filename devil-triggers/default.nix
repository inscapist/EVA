lib:

let nico = import ./nico lib;
in {
  theme = rec {
    # -> RRGGBB
    colors = import ./theme/palette.nix;

    # -> #RRGGBB
    xcolors = lib.mapAttrs (_: nico.colorlib.hex) colors;

    # -> rgba(,,,) colors (css)
    rgbaColors = lib.mapAttrs (_: nico.colorlib.rgba) colors;
  };
}
