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

{ inputs, pkgs, ... }:
{
  imports = [ inputs.kmonad.nixosModules.default ];

  services.kmonad = {
    enable = true;
    package = inputs.kmonad.packages.${pkgs.system}.default;
    keyboards = {
      one2mini = {
        device = "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = builtins.readFile (./. + "/sk71.kbd");
      };
    };
  };
}
