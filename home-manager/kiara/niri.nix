{ pkgs, ... }:

{

  home.packages = with pkgs; [
    qt6.qtwayland
    swaybg
    # in case of non-parsing configs
    alacritty
    fuzzel
  ];

}
