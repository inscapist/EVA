{
  services = {
    # # This is the most popular
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
    thermald.enable = true;

    # Check battery health with `upower -d`
    upower.enable = true;
  };

  # # This is what I was familiar with
  # powerManagement.powertop.enable = true;
}
