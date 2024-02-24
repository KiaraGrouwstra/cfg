{
  pkgs,
  ...
}:
{
  services.xserver.displayManager.defaultSession = "niri";

  # qt wayland: https://discourse.nixos.org/t/problem-with-qt-apps-styling/29450/8
  qt.platformTheme = "qt5ct";

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  environment.systemPackages = with pkgs; [swaybg];

}
