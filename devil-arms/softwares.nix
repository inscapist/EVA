{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brave
    firefox
    fractal
    gthumb
    lutris
    maim
    nitch
    obsidian
    pavucontrol
    poppler_utils
    qemu
    ranger
    slack
    tesseract
    virt-manager
    zathura
  ];

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    enableOnBoot = false;
    liveRestore = false;
  };

}
