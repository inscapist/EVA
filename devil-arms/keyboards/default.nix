# {
#   services.kanata = {
#     enable = false;

#     keyboards.sk71 = {
#       devices = [ "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd" ];
#       config = builtins.readFile (./. + "/sk71.kbd");
#       extraDefCfg = ''
#         ;; doesn't work because xset is not present in PATH
#         ;; linux-x11-repeat-delay-rate 250,60
#       '';
#     };
#   };
# }

{ pkgs, ... }:
{
  imports = [ ./kmonad.mod.nix ];

  environment.systemPackages = with pkgs; [
    keyd # monitor keys with "keyd monitor"
    via
  ];

  # QMK/VIA
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];

  # https://github.com/rvaiya/keyd/blob/master/docs/keyd.scdoc
  # https://github.com/rvaiya/keyd/blob/2338f11b1ddd81eaddd957de720a3b4279222da0/t/keys.py#L31
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          # SK71 remaps
          insert = "capslock";
          home = "mute";
          end = "brightnessup";
          delete = "brightnessdown";
          pageup = "volumeup";
          pagedown = "volumedown";

          # remap escape
          # escape = "grave";

          # overloads
          capslock = "overload(nav, esc)";
          tab = "overload(control, tab)";

          # introduce additional modifiers
          space = "lettermod(alt, space, 150, 200)";
          escape = "lettermod(win, grave, 150, 200)";
          backslash = "lettermod(control, backslash, 150, 200)";
        };
        "win" = {
          h = "C-A-h";
          l = "C-A-l";
        };
        "nav" = {
          r = "layer(nav-r)";
          w = "layer(nav-w)";
          s = "layer(nav-s)";
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          p = "C-A-h";
          n = "C-A-l";
          minus = "C-M-l";
          equal = "C-M-h";
          leftbrace = "C-A-h";
          rightbrace = "C-A-l";
          comma = "A-S-h";
          dot = "A-S-l";
          enter = "C-enter";
        };

        # resize
        "nav-r" = {
          h = "C-M-l";
          l = "C-M-h";
        };
        # window
        "nav-w" = {
          h = "C-A-h";
          l = "C-A-l";
        };
        # shift
        "nav-s" = {
          h = "A-S-h";
          l = "A-S-l";
        };
      };
    };
  };

  services.udev.extraRules = ''
    ATTRS{name}=="Keychron K7", SYMLINK+="keychron-k7-blue"
  '';

  services.kmonad = {
    enable = false;
    package = pkgs.kmonad;
    keyboards = {
      sk71 = {
        device = "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = builtins.readFile (./. + "/sk71.kbd");
      };
      k7 = {
        device = "/dev/input/by-id/usb-Keychron_Keychron_K7-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = builtins.readFile (./. + "/k7.kbd");
      };
      k7-bluetooth = {
        device = "/dev/keychron-k7-blue";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = builtins.readFile (./. + "/k7.kbd");
      };
    };
  };
}
