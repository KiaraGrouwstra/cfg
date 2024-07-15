{
  lib,
  pkgs,
  ...
}: {
  home.packages =
    lib.attrValues {
      inherit
        (pkgs)
        ## graphics
        
        imv
        ## audio
        
        cava
        ## video
        
        mpv
        vlc
        rhythmbox
        stremio # add providers for content, e.g. https://torrentio.strem.fun/
        
        ## 3d printing
        
        prusa-slicer
        ;
    };
}
