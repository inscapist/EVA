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
  age.secrets.wg0_conf = { file = ./wg0_conf.age; };
  age.secrets.userpass = { file = ./userpass.age; };
  age.secrets.restic_env = { file = ./restic_env.age; };
  age.secrets.restic_password = {
    file = ./restic_password.age;
    path = "/etc/restic-password";
  };
}
