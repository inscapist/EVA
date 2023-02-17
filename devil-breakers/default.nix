{ defaultUser, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { nix-doom-emacs = inputs.nix-doom-emacs; };

    users.${defaultUser} = {
      home.stateVersion = "23.05";
      imports = [ ./doom-emacs.nix ./git.nix ];
    };
  };
}
