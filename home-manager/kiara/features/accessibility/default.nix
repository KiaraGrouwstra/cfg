{pkgs, ...}: {
  home.packages = with pkgs; [
    ## mobile
    kdeconnect
    wvkbd

    ## speech / TTS
    speechd
    orca

    # AI
    local-ai
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
