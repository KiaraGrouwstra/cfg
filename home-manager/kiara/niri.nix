{ pkgs, ... }:

{

  home.packages = with pkgs; [
    swaybg
    # in case of non-parsing configs
    alacritty
    fuzzel
  ];

}
