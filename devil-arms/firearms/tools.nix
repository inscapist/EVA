{ pkgs, ... }: {
  environment = {
    variables = { EDITOR = "hx"; };
    systemPackages = with pkgs;
      [ which bat curl wget fd tree ripgrep jq fx git ] ++ [ neovim ]
      ++ [ httpie tokei tealdeer helix unrar zip unzip ]
      ++ [ dua duf htop btop glances iotop ]
      ++ [ gnumake graphviz gdb hexyl poppler_utils ]
      ++ [ tcpdump inetutils dig socat netcat ] ++ [ imagemagick imv ];
  };
}
