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

  # monitor keys with "keyd monitor"
  environment.systemPackages = [ pkgs.keyd ];

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
          escape = "grave";

          # overloads
          capslock = "overload(nav, esc)";
          backslash = "overload(control, backslash)";
          tab = "overload(control, tab)";

          # introduce additional modifiers
          space = "lettermod(alt, space, 150, 200)";
        };
        "nav" = {
          a = "layer(nav-a)";
          d = "layer(nav-d)";
          f = "layer(nav-f)";
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
        "nav-a" = {
          h = "C-M-l";
          l = "C-M-h";
        };
        "nav-d" = {
          h = "C-A-h";
          l = "C-A-l";
        };
        "nav-f" = {
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
