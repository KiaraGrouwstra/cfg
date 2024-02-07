{ pkgs, ... }:

pkgs.vscodium.override {
  commandLineArgs = "--ozone-platform=wayland";
}
