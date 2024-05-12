{
  home.persistence."/persist/home/kiara".directories = [
    ".config/wlsunset"
  ];
  services.wlsunset = {
    enable = true;
    gamma = "1.0";
    latitude = "52.0";
    longitude = "5.0";
    temperature = {
      day = 6000;
      night = 4600;
    };
    # sunrise = "06:30";
    # sunset = "18:00";
  };
}
