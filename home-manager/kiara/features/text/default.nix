{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    ./helix.nix
  ];

  home.packages = with pkgs; [
    ## text editors
    vim
    amp
    gnome-text-editor

    ## command-line document viewers / editors
    unixtools.column # lesspipe

    ## document viewers / editors
    evince
    calibre
    libreoffice-fresh
  ];

  programs.less.keys =
    if config.keyboard.active == "workman"
    then lib.readFile "${inputs.workman-vim}/lesskey"
    else "";

  programs.lesspipe.enable = true;
}
