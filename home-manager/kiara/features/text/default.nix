{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ## text editors
    vim
    amp
    hexyl
    gnome-text-editor

    ## command-line document viewers / editors
    unixtools.column # lesspipe

    ## markdown
    glow

    ## document viewers / editors
    evince
    calibre
    libreoffice-fresh
  ];

  programs.lesspipe.enable = true;

  # used by enhancd
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
