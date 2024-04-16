{ user, system, inputs, dt, ... }: {
  imports = [ inputs.hm.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = # make them available to hm modules
      with inputs;
      with dt; {
        inherit system theme;
      };

    users.${user} = {
      home = {
        stateVersion = "23.11";
        enableNixpkgsReleaseCheck = false;
      };

      nixpkgs.config = import ./dots/nixpkgs/config.nix;
      xdg.configFile."nixpkgs/config.nix".source = ./dots/nixpkgs/config.nix;
      xdg.configFile."i3/config".source = ./dots/i3/config;
      home.file.".xinitrc".source = ./dots/xinitrc;
      home.file.".Xresources".source = ./dots/Xresources;

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
        ./programs/nvim.nix

        # terminal
        ./shell/tmux.nix
        ./shell/zsh.nix
        ./terminals/alacritty.nix

        # spices
        ./desktop/desktop.nix
        ./desktop/gtk.nix
        ./desktop/xdg.nix
        ./slayer
      ];
    };
  };
}
