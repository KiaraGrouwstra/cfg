{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./kanshi.nix
  ];
  home.packages = lib.attrValues {
      inherit
        (pkgs)
        ## utilities
        gnome-maps

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
