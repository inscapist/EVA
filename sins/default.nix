{
  user,
  inputs,
  system,
  ...
}:

with inputs;
{
  imports = [ agenix.nixosModules.default ];
  environment.systemPackages = [ agenix.packages.${system}.default ];

  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    secretsDir = "/run/sins";
    secrets = {
      zsh_private = {
        file = ./zsh_private.age;
        mode = "400";
        owner = user;
      };
      wg0_conf = {
        file = ./wg0_conf.age;
      };
      userpass = {
        file = ./userpass.age;
      };
      restic_env = {
        file = ./restic_env.age;
        path = "/etc/restic-env";
      };
      restic_password = {
        file = ./restic_password.age;
        path = "/etc/restic-password";
      };
    };
  };
}
