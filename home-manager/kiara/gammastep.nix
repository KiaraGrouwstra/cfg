{
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 52.0;
    longitude = 5.0;
    temperature = {
      day = 5000;
      night = 4000;
    };
    settings = {general.adjustment-method = "wayland";};
  };
}
