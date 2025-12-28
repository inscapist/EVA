{ pkgs, ... }:
{

  # creates the agent service
  programs.ssh.startAgent = true;

  # Lid settings
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
  };

  security = {
    polkit.enable = true;
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    doas = {
      enable = false;
      extraConfig = ''
        permit nopass :wheel
      '';
    };
    # pam.services.i3lock = {
    #   text = ''
    #     auth include login
    #   '';
    # };
  };

  # TODO consider https://wiki.archlinux.org/title/GNOME/Keyring

  # security tweaks from Lord @hlissner
  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;

    ## TCP hardening
    # Prevent bogus ICMP errors from filling up logs.
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    # Reverse path filtering causes the kernel to do source validation of
    # packets received from all interfaces. This can mitigate IP spoofing.
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    # Do not accept IP source route packets (we're not a router)
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    # Don't send ICMP redirects (again, we're on a router)
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    # Refuse ICMP redirects (MITM mitigations)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    # Protects against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;
    # Incomplete protection again TIME-WAIT assassination
    "net.ipv4.tcp_rfc1337" = 1;

    ## TCP optimization
    # TCP Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender's initial TCP SYN. Setting 3 = enable TCP Fast Open for
    # both incoming and outgoing connections:
    "net.ipv4.tcp_fastopen" = 3;
    # Bufferbloat mitigations + slight improvement in throughput & latency
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";

    ## Should my machine act like a router?
    # "net.ipv4.ip_forward" = 1;
    # "net.ipv6.conf.all.forwarding" = 1;
  };
  boot.kernelModules = [ "tcp_bbr" ];

  security.tpm2 = {
    enable = true;
    # abrmd.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ fcron ];
  };

  # https://wiki.archlinux.org/title/ClamAV
  # https://gist.github.com/johnfedoruk/19820540dc096380784c8cf0b7ef333b
  #
  # Enable the ClamAV service and keep the database up to date
  # for initial installation, do `sudo freshclam && systemctl restart clamav-daemon && systemctl restart clamav-freshclam`
  # to check that daemon is running, do `systemctl status clamav-daemon`
  # for scanning, do `sudo clamscan`
  services.clamav = {
    daemon.enable = false;
    updater.enable = false;
    scanner = {
      enable = false;
      interval = "weekly";
      scanDirectories = [
        "/home/*/downloads"
        "/home/*/documents"
        "/tmp"
        "/var/tmp"
      ];
    };
  };
}
