{ pkgs, ... }:

{

  home.packages = with pkgs; [
    wayland
    niri-src
    qt6.qtwayland
    swaybg
    # in case of non-parsing configs
    alacritty
    fuzzel
  ];

}
