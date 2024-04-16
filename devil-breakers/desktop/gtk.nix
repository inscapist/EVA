{ pkgs, config, ... }: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "MonaspiceRn Nerd Font";
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Tela-yellow-dark";
      package = pkgs.tela-icon-theme;
    };

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/themes/orchis-theme/default.nix
    # nix-build '<nixpkgs>' -A orchis-theme --no-out-link
    theme = {
      name = "Orchis-Yellow-Dark-Compact";
      package = pkgs.orchis-theme.override {
        tweaks = [ "solid" "compact" ];
      };
    };
  };
}
