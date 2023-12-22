{ lib, config, pkgs, ... }:

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
      waybar
      swayidle
      playerctl
      pinentry-curses

      ## clipboard
      xclip
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
      wpgtk
      fontpreview

    ];

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.frappeDark;
      name = "Catppuccin-Frappe-Dark-Cursors";
      size = 48;
    };

    services.lorri = {
      enable = true;
    };

    services.playerctld.enable = true;

    programs.eww = {
      enable = true;
      configDir = ../../dotfiles/eww;
    };

  };
}
