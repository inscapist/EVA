{ pkgs, ... }: {
  environment = {
    variables = { EDITOR = "hx"; };
    systemPackages = with pkgs;
      [ which bat curl wget fd tree ripgrep jq fx git tig ]
      ++ [ httpie tokei tealdeer helix hexyl unrar zip unzip ]
      ++ [ dua duf htop btop iotop ] ++ [ graphviz gdb ]
      ++ [ brave firefox poppler_utils ]
      ++ [ tcpdump inetutils dig socat netcat ];
  };
}
