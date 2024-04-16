let
  # users
  sparda = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtsjUN63tlgndK6fx+hHPVo7rhncnIb+Y6A5ftx3vSY";

  # systems
  vergil = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbQuvzO7tRcdlwt462EGj/iqDKm9Clq2bH4A4B+os5x";

  keys = [
    sparda
    vergil
  ];
in
{
  "zsh_private.age".publicKeys = keys;
  "wg0_conf.age".publicKeys = keys;
  "1pass.age".publicKeys = keys;
  "userpass.age".publicKeys = keys;
  "restic_env.age".publicKeys = keys;
  "restic_password.age".publicKeys = keys;
}
