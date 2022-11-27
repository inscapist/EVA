{ config, pkgs, lib, ... }: {

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
    enableOnBoot = false;
    liveRestore = false;
  };

  programs.zsh.enable = true;

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
    man
    nodejs
    openssl
    ripgrep
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
