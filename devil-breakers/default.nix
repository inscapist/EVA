{ defaultUser, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = with inputs; { inherit nix-doom-emacs hyprland; };

    users.${defaultUser} = {
      home.stateVersion = "23.05";

      # Whether to enable fontconfig configuration. This will,
      # for example, allow fontconfig to discover fonts and
      # configurations installed through home.packages and nix-env.
      fonts.fontconfig.enable = true;

      imports = [
        # programs
        ./programs/browsers.nix
        ./programs/emacs.nix
        ./programs/filemanagers.nix
        ./programs/git.nix
        ./programs/ide.nix
        ./programs/nvim.nix

        # others
        ./shell/tmux.nix
        ./shell/zsh.nix
        ./terminals/alacritty.nix
        ./wayland/hyprland.nix
        ./wayland/notification.nix
      ];
    };
  };
}
