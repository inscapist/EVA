{ pkgs, config, ... }:
let
  browser = [ "brave.desktop" ];

  # XDG MIME types
  associations = {
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = [ "brave.desktop" ];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "audio/*" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.dekstop" ];
    "image/*" = [ "imv.desktop" ];
    "application/json" = browser;
    "application/pdf" = [ "org.pwmt.zathura.desktop.desktop" ];
    # "x-scheme-handler/discord" = [ "discordcanary.desktop" ];
    # "x-scheme-handler/spotify" = [ "spotify.desktop" ];
    # "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
  };
in {

  home.sessionVariables = {
    # xdg-settings get default-web-browser
    BROWSER = "brave";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [ xdg-utils ];

  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;

      # I don't want so many directories
      music = null;
      publicShare = null;
      templates = null;
      videos = null;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/pictures";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      };
    };
  };
}
