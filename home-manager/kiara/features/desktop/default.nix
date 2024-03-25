{pkgs, ...}: {
  home.packages = with pkgs; [
    ## UI
    waybar
    swayidle
    playerctl
    pinentry-curses
    ripdrag # yazi

    ## clipboard
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wl-clip-persist # make clipboard persist across app close
    cliphist

    ## process management
    monitor
    gnome.gnome-system-monitor
    btop

    ## notifications
    libnotify
    swaynotificationcenter

    ## utilities
    pavucontrol
    gnome.gnome-maps

    ## wallpapers / ricing
    swww # animated transitions
    waypaper # frontend
    pywal
    pywalfox-native
    wpgtk
    fontpreview
    wallust
  ];

  services.playerctld.enable = true;
}
