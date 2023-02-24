{ hyprland, pkgs, ... }: {

  imports = [ hyprland.homeManagerModules.default ];

  # Configuration
  # https://github.com/hyprwm/Hyprland/blob/main/nix/hm-module.nix
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = false;
      hidpi = true;
    };
    nvidiaPatches = false;
    systemdIntegration = true;
    extraConfig = "";
  };

  # https://wiki.hyprland.org/Configuring/Environment-variables/
  home.sessionVariables = {
    # XDG specifications
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # QT variables
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # Toolkit Backend Variables
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";

    # Theming
    # GTK_THEME = "";
    # XCURSOR_THEME = "";
    # XCURSOR_SIZE = "";

    # applications on wayland
    MOZ_ENABLE_WAYLAND = "1";
  };
}
