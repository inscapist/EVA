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

  services.udev.extraRules = ''
    ATTRS{name}=="Keychron K7", SYMLINK+="keychron-k7-blue"
  '';

  services.kmonad = {
    enable = true;
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
