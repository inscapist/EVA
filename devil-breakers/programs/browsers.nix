{ pkgs, ... }:

{
  programs = {
    # chromium = {
    #   enable = true;
    #   # package = pkgs.ungoogled-chromium;
    #   commandLineArgs = [

    #   ];
    #   extensions = [

    #   ];
    # };
    brave = { enable = true; };
    firefox = { enable = true; };
  };

  home.sessionVariables = {
    # xdg-settings get default-web-browser
    BROWSER = "brave";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
