{ defaultUser, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { nix-doom-emacs = inputs.nix-doom-emacs; };

    users.${defaultUser} = {
      home.stateVersion = "23.05";

      # Whether to enable fontconfig configuration. This will,
      # for example, allow fontconfig to discover fonts and
      # configurations installed through home.packages and nix-env.
      fonts.fontconfig.enable = true;

      imports = [
        ./editors.nix
        ./environment.nix
        ./file-managers.nix
        ./git.nix
        ./notification.nix
        ./terminals.nix
        ./tmux.nix
        ./zsh.nix
      ];
    };
  };
}
