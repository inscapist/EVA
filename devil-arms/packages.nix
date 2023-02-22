{ pkgs, ... }: {
  environment = {
    variables = { EDITOR = "hx"; };
    systemPackages = with pkgs;
      let
        clis = [ which bat curl wget exa fd fzf tree ripgrep jq fx ]
          ++ [ git tig lazygit ]
          ++ [ httpie tokei zip tealdeer helix hexyl unrar ]
          ++ [ dua duf glances htop btop iotop ] ++ [ graphviz jq gdb ]
          ++ [ tcpdump inetutils dig socat netcat ];
        others =
          [ duplicity cbonsai irssi slack obsidian zathura poppler_utils ];
        browsers = [ brave firefox ];
        os = [ lxappearance gthumb maim pavucontrol ranger xfce.thunar ];
      in clis ++ others ++ browsers ++ os;
  };
}
