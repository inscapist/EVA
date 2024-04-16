{ config, pkgs, ... }:
{
  systemd.timers."restic-backup" = {
    description = "Run backup every day at noon";
    enable = true;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 12:00:00";
      Persistent = true;
      Unit = "restic-backup.service";
    };
  };

  systemd.services."restic-backup" = {
    script = ''
      set -eu
      source ${config.age.secrets.restic_env.path}
      ${pkgs.restic}/bin/restic backup /work
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
