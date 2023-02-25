{ pkgs, ... }: {
  environment = {
    variables = { EDITOR = "hx"; };
    systemPackages = with pkgs;
      [ which bat curl wget fd tree ripgrep jq fx git tig ]
      ++ [ httpie tokei tealdeer helix hexyl unrar ]
      ++ [ dua duf htop btop iotop ] ++ [ graphviz gdb ]
      ++ [ firefox poppler_utils zathura ]
      ++ [ tcpdump inetutils dig socat netcat ];
  };
}
