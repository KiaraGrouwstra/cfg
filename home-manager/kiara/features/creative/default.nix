{pkgs, ...}: {
  home.packages = with pkgs; [
    ## graphics
    imv

    ## audio
    pamixer
    cava

    ## video
    mpv
    vlc
    rhythmbox
    stremio # add providers for content, e.g. https://torrentio.strem.fun/

    ## 3d printing
    prusa-slicer
    freecad
  ];
}
