{ pkgs, lib, inputs, ... }:

let
  programs = lib.makeBinPath
    [ inputs.hyprland.packages.${pkgs.hostPlatform.system}.default ];

  unplugged = pkgs.writeShellScript "unplugged" ''
    export PATH=$PATH:${programs}
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)

    systemctl --user --machine=1000@ stop easyeffects syncthing
    hyprctl --batch 'keyword decoration:drop_shadow 0 ; keyword animations:enabled 0'
  '';

  plugged = pkgs.writeShellScript "plugged" ''
    export PATH=$PATH:${programs}
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)

    systemctl --user --machine=1000@ start easyeffects syncthing
    hyprctl --batch 'keyword decoration:drop_shadow 1 ; keyword animations:enabled 1'
  '';
in {

  environment.systemPackages = with pkgs; [
    acpi # check battery level with `acpi -bi`
    powertop # use this to check detailed power usage
    s-tui
  ];

  services = {
    # # This is the most popular (superceded by auto-cpufreq)
    # tlp = {
    #   enable = true;
    #   settings = {
    #     PCIE_ASPM_ON_BAT = "powersupersave";
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #     CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
    #     NMI_WATCHDOG = 0;
    #   };
    # };

    # This is the more recent one
    auto-cpufreq.enable = true;

    # Monitor Intel CPU's temporature
    #   /necessity or legacy? swelling battery?/
    #   https://github.com/intel/thermal_daemon
    #   https://www.phoronix.com/review/intel-thermald-tgl
    thermald.enable = false;

    # Check battery health with `upower -d`
    upower.enable = true;

    udev.extraRules = ''
      # start/stop services on power (un)plug
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${plugged}"
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${unplugged}"
    '';
  };

  programs = {
    # backlight control
    light.enable = true;
  };

  # # This is what I was familiar with
  powerManagement.powertop.enable = true;

  networking.networkmanager.wifi.powersave = true;
}
