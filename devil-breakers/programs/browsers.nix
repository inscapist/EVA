{ pkgs, zen-browser, ... }:
{
  # home.packages = with pkgs; [ vivaldi ];

  imports = [
    # inputs.zen-browser.homeModules.beta
    zen-browser.homeModules.twilight
    # inputs.zen-browser.homeModules.twilight-official
  ];

  programs = {
    # chromium = {
    #   enable = true;
    #   # package = pkgs.ungoogled-chromium;
    #   commandLineArgs = [

    #   ];
    #   extensions = [

    #   ];
    # };
    brave = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };

  home.sessionVariables = {
    # xdg-settings get default-web-browser
    BROWSER = "brave";
  };
}
