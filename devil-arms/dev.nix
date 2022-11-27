{ config, pkgs, lib, ... }: {

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    #enableNvidia = true;
    enableOnBoot = false;
    liveRestore = false;
  };

  virtualisation.virtualbox = {
    host.enable = false;

    # Supports:
    #   USB 2.0/3.0 devices, VirtualBox RDP, disk encryption, NVMe and PXE boot for Intel cards
    host.enableExtensionPack = true;

    # VirtualBox Guest additions
    #virtualisation.virtualbox.guest.enable = true;
  };

  environment.variables = { EDITOR = "hx"; };

  environment.systemPackages = with pkgs; [
    bat
    cbonsai
    curl
    direnv
    dua
    duf
    duplicity
    exa
    fd
    fx
    fzf
    git
    glances
    gparted
    graphviz
    helix
    hexyl
    htop
    httpie
    inetutils
    iotop
    irssi
    jq
    kitty
    lazygit
    lshw
    lsof
    man
    neofetch
    nodejs
    nvtop
    openssl
    ripgrep
    s-tui
    tcpdump
    tig
    tealdeer
    tmux
    tokei
    tree
    unrar
    wget
    which
    zip
  ];
}
