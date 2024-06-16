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

  services.udev.extraRules = ''
    ATTRS{name}=="Keychron K7", SYMLINK+="keychron-k7-blue"
  '';

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
          capslock = "overload(nav, esc)";

          # introduce additional modifiers
          enter = "lettermod(alt, enter, 150, 200)";
          backslash = "lettermod(control, backslash, 150, 200)";
          tab = "lettermod(control, tab, 150, 200)";
          space = "lettermod(alt, space, 150, 200)";
          g = "lettermod(alt, g, 150, 200)";
        };
        "nav:C" = {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
          w = "C-right";
          b = "C-left";
        };
      };
    };
  };

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
