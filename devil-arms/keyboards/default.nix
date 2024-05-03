{
  services.kanata = {
    enable = true;

    keyboards.sk71 = {
      devices = [ "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd" ];
      config = builtins.readFile (./. + "/sk71.kbd");
      extraDefCfg = ''
        ;; doesn't work because xset is not present in PATH
        ;; linux-x11-repeat-delay-rate 250,60
      '';
    };
  };
}
