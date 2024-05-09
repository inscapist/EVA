{ pkgs, config, ... }:
let
  browser = config.home.sessionVariables.BROWSER;
  browsers = [ "${browser}.desktop" ];

  # XDG MIME types
  associations = {
    "inode/directory" = [ "yazi" ];
    "application/x-extension-htm" = browsers;
    "application/x-extension-html" = browsers;
    "application/x-extension-shtml" = browsers;
    "application/x-extension-xht" = browsers;
    "application/x-extension-xhtml" = browsers;
    "application/xhtml+xml" = browsers;
    "text/html" = browsers;
    "x-scheme-handler/about" = browsers;
    "x-scheme-handler/chrome" = browsers;
    "x-scheme-handler/ftp" = browsers;
    "x-scheme-handler/http" = browsers;
    "x-scheme-handler/https" = browsers;
    "x-scheme-handler/unknown" = browsers;

    "audio/*" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
    "image/*" = [ "imv.desktop" ];
    "application/json" = browsers;
    "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.deskto" ];
    "application/vnd.rar" = [ "org.kde.ark.desktop" ];
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer.desktop" ];
    # "x-scheme-handler/discord" = [ "discordcanary.desktop" ];
    # "x-scheme-handler/spotify" = [ "spotify.desktop" ];
    # "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
  };
in
{
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
      desktop = null;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/pictures";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}";
      };
    };
  };
}
