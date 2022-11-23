{ pkgs, ... }: {

  environment.variables = {
    EDITOR = "hx";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    bat
    curl
    direnv
    dua
    duf
    duplicity
    exa
    fd
    firefox
    fx
    fzf
    git
    glances
    gparted
    graphviz
    helix
    hexyl
    hicolor-icon-theme # lutris
    htop
    httpie
    inetutils
    iotop
    irssi
    jq
    lazygit
    lshw
    lsof
    lutris
    man
    neofetch
    nodejs
    nvtop
    pavucontrol
    perl # for fzf history
    ranger
    ripgrep
    s-tui
    tcpdump
    tig
    tealdeer # faster tldr
    tmux
    tokei
    tree
    wget
    which
    zip
  ];
}
