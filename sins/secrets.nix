let
  sparda =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtsjUN63tlgndK6fx+hHPVo7rhncnIb+Y6A5ftx3vSY";

  vergil =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbQuvzO7tRcdlwt462EGj/iqDKm9Clq2bH4A4B+os5x";

  keys = [ sparda vergil ];
in { "zsh_private.age".publicKeys = keys; }
