{ user, inputs, dt, ... }: {
  imports = [ inputs.hm.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = # make them available to hm modules
      with inputs;
      with dt; {
        inherit emacs-overlay doom hyprland hyprland-contrib;
        inherit theme;
      };

    users.${user} = {
      home = { stateVersion = "23.05"; };

      # Whether to enable fontconfig configuration. This will,
      # for example, allow fontconfig to discover fonts and
      # configurations installed through home.packages and nix-env.
      fonts.fontconfig.enable = true;

      imports = [
        # essentials
        ./programs/browsers.nix
        ./programs/emacs.nix
        ./programs/filemanagers.nix
        ./programs/git.nix
        ./programs/ide.nix
        ./programs/notification.nix
        ./programs/nvim.nix

        # terminal
        ./shell/tmux.nix
        ./shell/zsh.nix
        ./terminals/alacritty.nix

        # spices
        ./desktop/gtk.nix
        ./desktop/xdg.nix
        ./slayer
        ./wayland
      ];
    };
  };
}
