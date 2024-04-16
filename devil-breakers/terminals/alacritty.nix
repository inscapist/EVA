{ ... }:
{

  programs = {
    alacritty = {
      enable = true;
    };
  };

  home = {
    sessionVariables = {
      TERMINAL = "alacritty";
    };
    file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  };
}
