{ pkgs, ... }: {

  programs = {
    alacritty = {
      enable = true;
      # settings = {
      #   window.dimensions = {
      #     lines = 3;
      #     columns = 200;
      #   };
      #   key_bindings = [{
      #     key = "K";
      #     mods = "Control";
      #     chars = "\\x0c";
      #   }];
      # };
    };
  };

  home.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Agave" ]; }) ];

  home.file.".config/alacritty/alacritty.yml".source =
    ./alacritty/alacritty.yml;
}
