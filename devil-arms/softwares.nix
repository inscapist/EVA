{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    lxappearance
    brave
    firefox
    fractal
    gthumb
    # lutris
    maim
    nitch
    obsidian
    pavucontrol
    poppler_utils
    ranger
    slack
    tesseract
    zathura
  ];

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    enableOnBoot = false;
    liveRestore = false;
  };

}
