{ lib, config, pkgs, inputs, ... }:

with lib;

let cfg = config.toggles.desktop;
in {
  options.toggles.desktop.enable = mkEnableOption "desktop";

  # imports = lib.optionals cfg.enable [
  # # imports = [
  # #   ./gammastep.nix
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## UI
      wayland
      niri-src
      waybar
      swayidle
      playerctl
      pinentry-curses

      ## clipboard
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wl-clip-persist # make clipboard persist across app close
      cliphist

      ## process management
      monitor
      gnome.gnome-system-monitor
      htop

      ## notifications
      libnotify
      swaynotificationcenter

      ## utilities
      wdisplays
      gnome.gnome-characters
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

    services.lorri = { enable = true; };

    services.playerctld.enable = true;

  };
}
