{pkgs, ...}: {
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

  programs.lesspipe.enable = true;
}
