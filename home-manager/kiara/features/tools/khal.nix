{pkgs, ...}: {
  home.packages = [pkgs.khal];
  # https://github.com/pimutils/khal/blob/master/khal.conf.sample
  xdg.configFile."khal/config".text =
    /*
    toml
    */
    ''
      [calendars]

      [[calendars]]
      path = ~/Calendars/*
      type = discover

      [locale]
      timeformat = %H:%M
      dateformat = %d/%m/%Y
      default_timezone = Europe/Amsterdam
      local_timezone = Europe/Amsterdam

      [keybindings]
      external_edit = w
    '';
}
