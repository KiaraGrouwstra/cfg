{
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 52.0;
    longitude = 5.0;
    temperature = {
      day = 6000;
      night = 4600;
    };
    settings = {general.adjustment-method = "wayland";};
  };
}
