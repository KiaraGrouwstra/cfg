{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.toggles.niri;
in {
  options.toggles.niri.enable = mkEnableOption "niri";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    services.xserver.displayManager.defaultSession = "niri";

    # xdg-desktop-portal uses D-Bus
    services.dbus.enable = true;

    # qt wayland: https://discourse.nixos.org/t/problem-with-qt-apps-styling/29450/8
    qt.platformTheme = "qt5ct";

    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [swaybg];

    systemd.user.services.swaybg = {
      enable = true;
      script = "${pkgs.swaybg}/bin/swaybg";
      # scriptArgs = "-m fill -i \"%h/Pictures/wallpapers/wallpaperflare.com_wallpaper(2).jpg\"";
      restartTriggers = ["on-failure"];
      unitConfig = {
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
        Requisite = "graphical-session.target";
      };
    };

    systemd.user.services.niri.wants = ["waybar.service" "swaync.service" "swaybg.service"];

    # programs.xwayland.enable = true;
  };
}
