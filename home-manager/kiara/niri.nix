{ pkgs, ... }:

{

  home.packages = with pkgs; [
    swaybg
    xwayland
    # in case of non-parsing configs
    alacritty
    fuzzel
  ];

}
