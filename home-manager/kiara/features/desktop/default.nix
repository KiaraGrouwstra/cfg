{pkgs, ...}: {
  home.packages = with pkgs; [
    ## UI
    waybar
    pinentry-curses

    ## clipboard
    wl-clip-persist # make clipboard persist across app close

    ## process management
    monitor

    ## utilities
    gnome.gnome-maps

    ## wallpapers / ricing
    waypaper # frontend
    pywal
    pywalfox-native
    wpgtk
    fontpreview
  ];

  services.playerctld.enable = true;
}
