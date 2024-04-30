_: {
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  # See https://linrunner.de/en/tlp/docs/tlp-faq.html#battery
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
    CPU_SCALING_GOVERNOR_ON_AC = "powersave";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    ENERGY_PERF_POLICY_ON_AC = "powersave";
    ENERGY_PERF_POLICY_ON_BAT = "powersave";
  };
}
