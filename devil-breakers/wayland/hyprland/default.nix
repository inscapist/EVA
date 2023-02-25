{ theme, lib, config, hyprland, hyprland-contrib, pkgs, ... }: {

  imports = [ hyprland.homeManagerModules.default ./session.nix ];

  home.packages = with pkgs; [
    xorg.xprop
    hyprland-contrib.packages.${pkgs.hostPlatform.system}.grimblast
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
      # exec-once = eww open bar

      misc {
        disable_hyprland_logo = 1
        focus_on_activate = 1
      }

      input {
        kb_layout = us
        kb_options = "caps:escape"
        repeat_rate = 60
        repeat_delay = 250
      }

      general {
        gaps_in = 5
        gaps_out = 5
        border_size = 2
        col.active_border = rgb(${colors.blue}) rgb(${colors.mauve}) 270deg
        col.inactive_border = rgb(${colors.crust}) rgb(${colors.lavender}) 270deg
      }

      decoration {
        rounding = 16
        blur = 1
        blur_size = 3
        blur_passes = 3
        blur_new_optimizations = 1

        drop_shadow = 1
        shadow_ignore_window = 1
        shadow_offset = 2 2
        shadow_range = 4
        shadow_render_power = 1
        col.shadow = 0x55000000
      }

      animations {
        enabled = 1
        animation = border, 1, 2, default
        animation = fade, 1, 4, default
        animation = windows, 1, 3, default, popin 80%
        animation = workspaces, 1, 2, default, slide
      }

      dwindle {
        # keep floating dimentions while tiling
        pseudotile = 1
        preserve_split = 1

        # group borders
        col.group_border_active = rgb(${colors.pink})
        col.group_border = rgb(${colors.surface0})
      }

      # mouse movements
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
      bindm = $mod ALT, mouse:272, resizewindow

      # compositor commands
      bind = $mod SHIFT, E, exec, pkill Hyprland
      bind = $mod, Q, killactive,
      bind = $mod, F, fullscreen,
      bind = $mod, G, togglegroup,
      bind = $mod SHIFT, N, changegroupactive, f
      bind = $mod SHIFT, P, changegroupactive, b
      bind = $mod, R, togglesplit,
      bind = $mod, T, togglefloating,
      bind = $mod, P, pseudo,
      bind = $mod ALT, ,resizeactive,
      # toggle "monocle" (no_gaps_when_only)
      $kw = dwindle:no_gaps_when_only
      bind = $mod, M, exec, hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))

      # utility
      # launcher
      bindr = $mod, SUPER_L, exec, pkill .${launcher}-wrapped || run-as-service ${launcher}
      # terminal
      bind = $mod, Return, exec, run-as-service ${terminal}
      # logout menu
      bind = $mod, Escape, exec, wlogout -p layer-shell
      # lock screen
      bind = $mod, L, exec, loginctl lock-session
      # emoji picker
      bind = $mod, E, exec, ${emoji}
      # select area to perform OCR on
      bind = $mod, O, exec, run-as-service wl-ocr

      # move focus
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d

      # window resize
      bind = $mod, S, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # media controls
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindl = , XF86AudioNext, exec, playerctl next

      # volume
      bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%+
      binde = , XF86AudioRaiseVolume, exec, ${homeDir}/.config/eww/scripts/volume osd
      bindle = , XF86AudioLowerVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%-
      binde = , XF86AudioLowerVolume, exec, ${homeDir}/.config/eww/scripts/volume osd
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioMute, exec, ${homeDir}/.config/eww/scripts/volume osd
      bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      # backlight
      bindle = , XF86MonBrightnessUp, exec, light -A 5
      binde = , XF86MonBrightnessUp, exec, ${homeDir}/.config/eww/scripts/brightness osd
      bindle = , XF86MonBrightnessDown, exec, light -U 5
      binde = , XF86MonBrightnessUp, exec, ${homeDir}/.config/eww/scripts/brightness osd

      # screenshot
      # stop animations while screenshotting; makes black border go away
      $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copysave area; hyprctl keyword animation "fadeOut,1,4,default"
      bind = , Print, exec, $screenshotarea
      bind = $mod SHIFT, R, exec, $screenshotarea

      bind = CTRL, Print, exec, grimblast --notify --cursor copysave output
      bind = $mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output

      bind = ALT, Print, exec, grimblast --notify --cursor copysave screen
      bind = $mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen

      # workspaces
      # binds mod + [shift +] {1..10} to [move to] ws {1..10}
      ${builtins.concatStringsSep "\n" (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        '') 10)}

      # special workspace
      bind = $mod SHIFT, grave, movetoworkspace, special
      bind = $mod, grave, togglespecialworkspace, eDP-1

      # cycle workspaces
      bind = $mod, bracketleft, workspace, m-1
      bind = $mod, bracketright, workspace, m+1
      # cycle monitors
      bind = $mod SHIFT, braceleft, focusmonitor, l
      bind = $mod SHIFT, braceright, focusmonitor, r
    '';
  };
}
