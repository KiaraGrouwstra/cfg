{pkgs, ...}: {
  home.packages = with pkgs; [
    ## mobile
    kdeconnect
    wvkbd

    ## speech / TTS
    speechd
    orca
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
