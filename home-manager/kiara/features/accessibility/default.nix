{pkgs, ...}: {
  home.packages = with pkgs; [
    ## mobile
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
