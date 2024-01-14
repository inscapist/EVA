{ user, system, inputs, dt, sdt, ... }: {
  imports = [ inputs.hm.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = # make them available to hm modules
      with inputs;
      with dt; {
        inherit emacs-overlay doom hyprland hyprland-contrib eww;
        inherit system theme;
      };

    users.${user} = {
      home = {
        stateVersion = "23.11";
        enableNixpkgsReleaseCheck = false;
      };

      nixpkgs.config = import ./nixpkgs-config.nix;
      xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

      # Whether to enable fontconfig configuration. This will,
      # for example, allow fontconfig to discover fonts and
      # configurations installed through home.packages and nix-env.
      fonts.fontconfig.enable = true;

      imports = [
        # essentials
        ./programs/browsers.nix
        ./programs/dunst.nix
        ./programs/emacs.nix
        ./programs/filemanagers.nix
        ./programs/git.nix
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

        # sin devil triggers
        sdt.hmModules
      ];
    };
  };
}
