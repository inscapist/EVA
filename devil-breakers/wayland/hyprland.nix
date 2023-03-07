{ theme, lib, config, hyprland, hyprland-contrib, pkgs, system, ... }: {

  imports = [ hyprland.homeManagerModules.default ];

  # https://wiki.hyprland.org/Configuring/Environment-variables/
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  home.packages = with pkgs; [
    jq
    xorg.xprop
    hyprland-contrib.packages.${system}.grimblast
  ];

  # start swayidle as part of hyprland, not sway
  # systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  # Configuration
  # https://github.com/hyprwm/Hyprland/blob/main/nix/hm-module.nix
  wayland.windowManager.hyprland = let
    inherit (theme) colors;
    pointer = config.home.pointerCursor;
    homeDir = config.home.homeDirectory;
    terminal = "alacritty";
    browser = "brave";
    explorer = "nemo";

    # wofi
    emoji = "${pkgs.wofi-emoji}/bin/wofi-emoji";
    launcher = "wofi";
  in {
    enable = true;
    xwayland = {
      enable = false;
      hidpi = false;
    };
    nvidiaPatches = false;
    systemdIntegration = true;
    extraConfig = ''
      $mod = ALT

      # scale apps
      # exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
      exec-once = hyprctl setcursor ${pointer.name} ${toString pointer.size}
      exec-once = eww open bar
      exec-once = light -S 0

      # laptop screen
      monitor = eDP-1, preferred, 0x0, 2

      # dell 4k monitor
      # monitor = , preferred, auto, auto
      monitor = DP-2, preferred, 1920x0, auto

      # default workspace for monitors
      # workspace = DP-3, 1
      # workspace = eDP-1, 10

      # laptop screen is a peripheral screen for secondary stuff
      # use MOD+SHIFT+h|l or MOD+SHIFT+left|right to move between monitors
      wsbind = 1, eDP-1
      wsbind = 2, DP-2
      wsbind = 3, DP-2
      wsbind = 4, DP-2
      wsbind = 5, DP-2
      wsbind = 6, DP-2
      wsbind = 7, DP-2
      wsbind = 8, DP-2
      wsbind = 9, DP-2
      wsbind = 10, DP-2

      misc {
        disable_hyprland_logo = true
        focus_on_activate = true
      }

      input {
        kb_layout = us
        kb_options = caps:escape
        repeat_rate = 50
        repeat_delay = 200
      }

      general {
        gaps_in = 5
        gaps_out = 5
        border_size = 2
        col.active_border = rgb(${colors.blue}) rgb(${colors.mauve}) 270deg
        col.inactive_border = rgb(${colors.crust}) rgb(${colors.lavender}) 270deg

        # group borders
        # col.group_border = rgb(${colors.surface0})
        # col.group_border_active = rgb(${colors.pink})
      }

      decoration {
        rounding = 16
        blur = true
        blur_size = 3
        blur_passes = 3
        blur_new_optimizations = true

        active_opacity = 0.95
        inactive_opacity = 0.85
        fullscreen_opacity = 1

        drop_shadow = true
        shadow_ignore_window = true
        shadow_offset = 2 2
        shadow_range = 4
        shadow_render_power = 1
        col.shadow = 0x55000000
      }

      animations {
        enabled = true
        animation = border, 1, 2, default
        animation = fade, 1, 4, default
        animation = windows, 1, 3, default, popin 80%
        animation = workspaces, 1, 2, default, slide
      }

      dwindle {
        # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
        pseudotile = true
      }

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      # Compositor commands
      bind = $mod SHIFT, E, exec, pkill Hyprland
      bind = $mod, Q, killactive,
      bind = $mod, F, fullscreen,
      bind = $mod, G, togglegroup,
      bind = SUPER, L, changegroupactive, f
      bind = SUPER, H, changegroupactive, b
      # bind = $mod, R, togglesplit,
      bind = $mod, T, togglefloating,
      bind = $mod SHIFT, P, pseudo,
      bind = $mod SUPER, ,resizeactive,

      # toggle "monocle" (no_gaps_when_only)
      $kw = dwindle:no_gaps_when_only
      bind = $mod, M, exec, hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jq -r '.int') ^ 1))

      # utilities
      bind = $mod, Space, exec, ${launcher}
      bind = $mod, Return, exec, ${terminal}
      bind = $mod CTRL, Return, exec, ${browser}
      bind = $mod CTRL, M, exec, ${explorer}
      bind = $mod SHIFT, Q, exec, wlogout -p layer-shell
      bind = SUPER SHIFT, L, exec, loginctl lock-session

      # emoji picker
      bind = $mod, E, exec, ${emoji}

      # select area to perform OCR on
      bind = $mod, O, exec, wl-ocr

      # move focus
      bind = $mod, H, movefocus, l
      bind = $mod, L, movefocus, r
      bind = $mod, K, movefocus, u
      bind = $mod, J, movefocus, d

      # move window
      bind = $mod SHIFT, H, movewindow, l
      bind = $mod SHIFT, L, movewindow, r
      bind = $mod SHIFT, K, movewindow, u
      bind = $mod SHIFT, J, movewindow, d

      # move window (https://www.reddit.com/r/hyprland/comments/10izfpf/moving_window_between_monitors/)
      bind = $mod SHIFT, left, movewindow, mon:l
      bind = $mod SHIFT, right, movewindow, mon:r

      bind = $mod, left, focusmonitor, l
      bind = $mod, right, focusmonitor, r

      # window resize
      binde = $mod CTRL, right, resizeactive, 10 0
      binde = $mod CTRL, left, resizeactive, -10 0
      binde = $mod CTRL, up, resizeactive, 0 -10
      binde = $mod CTRL, down, resizeactive, 0 10

      # volume
      bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%+
      binde = , XF86AudioRaiseVolume, exec, ${homeDir}/.config/eww/scripts/volume osd
      bindle = , XF86AudioLowerVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%-
      binde = , XF86AudioLowerVolume, exec, ${homeDir}/.config/eww/scripts/volume osd
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioMute, exec, ${homeDir}/.config/eww/scripts/volume osd
      bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      # backlight
      bindle = , XF86MonBrightnessUp, exec, light -A 1
      binde = , XF86MonBrightnessUp, exec, ${homeDir}/.config/eww/scripts/brightness osd
      bindle = , XF86MonBrightnessDown, exec, light -U 1
      binde = , XF86MonBrightnessUp, exec, ${homeDir}/.config/eww/scripts/brightness osd

      # screenshot
      # stop animations while screenshotting; makes black border go away
      $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
      bind = , F3, exec, $screenshotarea
      bind = $mod SHIFT, R, exec, $screenshotarea
      bind = $mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output

      # workspaces
      # binds mod + [shift +] {1..10} to [move to] ws {1..10}
      ${builtins.concatStringsSep "\n" (builtins.genList (x:
        let
          str = builtins.toString;
          # if x+1 == 10, ws -> 0, else ws == x+1
          # because c is only == 1 when x+1 == 10
          ws = let c = (x + 1) / 10; in x + 1 - (c * 10);
        in ''
          bind = $mod, ${str ws}, workspace, ${str (x + 1)}
          bind = $mod SHIFT, ${str ws}, movetoworkspace, ${str (x + 1)}
        '') 10)}

      # workspaces (arrow navigation)
      bind = SUPER, left, workspace, -1
      bind = SUPER, right, workspace, +1

      # window rules
      windowrulev2 = opaque,title:^(firefox)$
      windowrulev2 = opaque,title:^(brave)$
      windowrulev2 = workspace 5,title:^(Slack)$

      # throw sharing indicators away
      windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
      windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$
    '';
  };
}
