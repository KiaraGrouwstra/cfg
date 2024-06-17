{
  lib,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/castero"
  ];
  home.packages =
    lib.attrValues {
      inherit
        (pkgs)
        ## graphics
        
        imv
        ## audio
        
        castero
        cava
        ## video
        
        mpv
        vlc
        rhythmbox
        stremio # add providers for content, e.g. https://torrentio.strem.fun/
        
        ## 3d printing
        
        prusa-slicer
        freecad
        ;
    };
}
