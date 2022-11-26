{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    brave
    firefox
    fractal
    gthumb
    lutris
    maim
    neofetch
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
}
