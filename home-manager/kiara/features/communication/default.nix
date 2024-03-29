{pkgs, ...}: {
  home.packages = with pkgs; [
    ## email
    betterbird
    offlineimap
    hydroxide

    ## chat / communications
    telegram-desktop
    flare

    ## web browsers
    wget
    curl
  ];
}
