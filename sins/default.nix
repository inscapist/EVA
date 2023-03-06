{ user, inputs, system, ... }:

with inputs; {
  imports = [ agenix.nixosModules.default ];
  environment.systemPackages = [ agenix.packages.${system}.default ];

  age.secretsDir = "/run/sins";
  age.secrets.zsh_private = {
    file = ./zsh_private.age;
    mode = "400";
    owner = user;
  };
}
