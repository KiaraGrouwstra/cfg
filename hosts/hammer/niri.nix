{
  pkgs,
  inputs,
  lib,
  ...
}: {
  nixpkgs.overlays = [inputs.niri.overlays.niri];

  services.displayManager.defaultSession = "niri";

  # qt wayland: https://discourse.nixos.org/t/problem-with-qt-apps-styling/29450/8
  qt.platformTheme.name = "qt5ct";

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  xdg.portal = {
    enable = true;
    lxqt = {
      enable = true;
      styles = [pkgs.libsForQt5.qtstyleplugin-kvantum];
    };
    extraPortals = lib.attrValues {
      inherit
        (pkgs)
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        ;
    };
  };
}
