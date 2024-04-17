{pkgs, ...}: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/swaylock"
  ];
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      effect-blur = "20x3";
      fade-in = 0.1;
      font-size = 125;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 40;
      indicator-idle-visible = true;
      indicator-x-position = 1600;
      indicator-y-position = 1000;
      # indicator
      # clock
      timestr = "%I:%M %p";
      datestr = "%A, %d %B";
    };
  };
}
