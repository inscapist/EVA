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

    # to change, run `systemctl restart swaybg`
    wallpaper = "${./portals/she-looks-at-you.jpg}";
    # lockscreen = builtins.fetchurl rec {
    #   name = "wallpaper-${sha256}.png";
    #   url = "https://files.catbox.moe/wn3b28.png";
    #   sha256 = "0f7q0aj1q6mjfh248j8dflfbkbcpfvh5wl75r3bfhr8p6015jkwq";
    # };

    lockscreen = "${./portals/gun-aim.jpg}";
  };
}
