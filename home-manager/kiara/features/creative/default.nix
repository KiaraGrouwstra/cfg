{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ## graphics
    # imv  # insecure
    gnome.eog

    ## audio
    pamixer
    cava

    ## video
    mpv
    vlc
    stremio # add providers for content, e.g. https://torrentio.strem.fun/

    ## 3d printing
    prusa-slicer
    freecad
  ];
}
