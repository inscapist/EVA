{ pkgs, zen-browser, ... }:
{
  imports = [
    # inputs.zen-browser.homeModules.beta
    zen-browser.homeModules.twilight
    # inputs.zen-browser.homeModules.twilight-official
  ];

  programs = {
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
