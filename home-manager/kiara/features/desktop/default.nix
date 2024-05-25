{
  pkgs,
  lib,
  ...
}: {
  home.packages =
    [
      ## utilities
      pkgs.gnome.gnome-maps
    ]
    ++ lib.attrValues {
      inherit
        (pkgs)
        ## UI
        
        waybar
        pinentry-curses
        ## clipboard
        
        wl-clip-persist # make clipboard persist across app close
        
        ## process management
        
        monitor
        ## wallpapers / ricing
        
        waypaper # frontend
        pywal
        pywalfox-native
        wpgtk
        fontpreview
        ;
    };

  services.playerctld.enable = true;
}
