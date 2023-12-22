{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.hyprland;
in {
  options.toggles.hyprland.enable = mkEnableOption "hyprland";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    services.xserver.displayManager.defaultSession = "hyprland";

    programs.hyprland = {
      enable = true;
    };

    # xdg-desktop-portal works by exposing a series of D-Bus interfaces
    # known as portals under a well-known name
    # (org.freedesktop.portal.Desktop) and object path
    # (/org/freedesktop/portal/desktop).
    # The portal interfaces include APIs for file access, opening URIs,
    # printing and others.
    services.dbus.enable = true;
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
