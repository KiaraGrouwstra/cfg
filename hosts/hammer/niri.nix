{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.niri.overlays.niri];

  environment.noXlibs = true;

  services.displayManager.defaultSession = "niri";

  # qt wayland: https://discourse.nixos.org/t/problem-with-qt-apps-styling/29450/8
  qt.platformTheme.name = "qt5ct";

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
