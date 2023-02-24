{ pkgs, ... }: {

  home.sessionVariables = { TERMINAL = "alacritty"; };

  programs = { alacritty = { enable = true; }; };

  home.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Agave" ]; }) ];

  home.file.".config/alacritty/alacritty.yml".source =
    ./alacritty/alacritty.yml;

}
