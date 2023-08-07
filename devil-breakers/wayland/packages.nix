{ pkgs, lib, ... }:

let
  # use OCR and copy to clipboard
  # ocrScript = let
  #   inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
  #   _ = lib.getExe;
  # in pkgs.writeShellScriptBin "wl-ocr" ''
  #   ${_ grim} -g "$(${_ slurp})" -t ppm - | ${
  #     _ tesseract5
  #   } - - | ${wl-clipboard}/bin/wl-copy
  #   ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
  # '';
in {

  # programs.eww-hyprland = {
  #   enable = true;
  #   package = inputs.eww.packages.${pkgs.hostPlatform.system}.eww-wayland;
  # };

  home.packages = with pkgs; [
    # screenshot
    grim
    slurp

    # idle/lock
    swaybg
    swaylock-effects

    # utils
    # ocrScript
    wf-recorder
    wl-clipboard
    wlogout
    wlr-randr
    wofi
  ];

  # programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
}
