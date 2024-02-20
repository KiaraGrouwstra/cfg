{
  pkgs,
  ...
}:
{
  services.xserver.displayManager.defaultSession = "niri";

  # xdg-desktop-portal uses D-Bus
  services.dbus.enable = true;

  # qt wayland: https://discourse.nixos.org/t/problem-with-qt-apps-styling/29450/8
  qt.platformTheme = "qt5ct";

  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [swaybg];

  # programs.xwayland.enable = true;
}
