{ defaultUser, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { nix-doom-emacs = inputs.nix-doom-emacs; };

    users.${defaultUser} = {
      home.stateVersion = "23.05";
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
