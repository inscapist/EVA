{ pkgs, ... }: {
  environment = {
    variables = { EDITOR = "hx"; };
    systemPackages = with pkgs;
      let
        clis = [ which bat curl wget fd tree ripgrep jq fx ] ++ [ git tig ]
          ++ [ httpie tokei zip tealdeer helix hexyl unrar ]
          ++ [ dua duf glances htop btop iotop ] ++ [ graphviz gdb ]
          ++ [ tcpdump inetutils dig socat netcat ];
        others =
          [ duplicity cbonsai irssi slack obsidian zathura poppler_utils ];
        browsers = [ brave firefox ];
        os = [ lxappearance gthumb maim pavucontrol ];
      in clis ++ others ++ browsers ++ os;
  };
}
