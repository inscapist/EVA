{ user, inputs, dt, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = with inputs; {
      inherit nix-doom-emacs hyprland;
      inherit dt;
    };

    users.${user} = {
      home = {
        stateVersion = "23.05";
        extraOutputsToInstall = [ "doc" "devdoc" ];
      };

      # Whether to enable fontconfig configuration. This will,
      # for example, allow fontconfig to discover fonts and
      # configurations installed through home.packages and nix-env.
      fonts.fontconfig.enable = true;

      # TODO use profiles with "xi@vergil"
      imports = [
        # essentials
        ./programs/browsers.nix
        ./programs/emacs.nix
        ./programs/filemanagers.nix
        ./programs/git.nix
        ./programs/ide.nix
        ./programs/nvim.nix
        ./shell/tmux.nix
        ./shell/zsh.nix
        ./terminals/alacritty.nix

        # spices
        ./desktop/gtk.nix
        ./desktop/xdg.nix
        ./wayland/hyprland.nix
        ./wayland/notification.nix
      ];
    };
  };
}
