{
  lib,
  pkgs,
  lime3ds,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/castero"
  ];
  home.packages =
    [
      lime3ds.lime3ds
    ]
    ++ lib.attrValues {
      inherit
        (pkgs)
        lutris
        retro-gtk
        retroarch
        # retroarchFull
        
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
