{ config, lib, pkgs, ... }:

{
  # Steam launch reminders (4K monitor is capped at 60 Hz per `xrandr`):
  #   4K 60Hz:     gamemoderun gamescope -w 3840 -h 2160 -r 60 -- %command%
  #   1440p 60Hz:  gamemoderun gamescope -w 2560 -h 1440 -r 60 -- %command%
  # tweak resolution if you need lighter loads, but keep -r 60 for this panel.

  boot.kernel.sysctl = {
    # keep sampling tools like `perf` usable without sudo
    "kernel.perf_event_paranoid" = "-1";
    # free up a watchdog core and reduce unnecessary interrupts
    "kernel.nmi_watchdog" = "0";
    # favor RAM over swap to avoid frame-hitching
    "vm.swappiness" = "10";
    "vm.dirty_ratio" = "20";
    "vm.dirty_background_ratio" = "5";
  };

  systemd = {
    # oomd is aggressive with large games; skip it and rely on cgroup limits
    oomd.enable = lib.mkForce false;
    services."NetworkManager-wait-online".enable = lib.mkDefault false;
  };

  # keep the CPU pinned to its performance governor while gaming
  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

  # avoid dueling policies with auto-cpufreq; gamemode will handle boosts
  services.auto-cpufreq.enable = lib.mkForce false;

  hardware.steam-hardware.enable = lib.mkDefault true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    gamescope
    goverlay
    mangohud
    nvtopPackages.nvidia
    vkbasalt
    vulkan-tools
  ];
}
