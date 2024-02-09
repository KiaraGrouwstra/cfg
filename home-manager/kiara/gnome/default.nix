{ pkgs, ... }:

{

  imports = [ ./paperwm.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.random-wallpaper
    gnomeExtensions.emoji-copy
    gnomeExtensions.switch-x11-wayland-default-session
    gnomeExtensions.zoom-wayland-extension
  ];

}
