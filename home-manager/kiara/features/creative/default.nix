{
  lib,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/hullcaster"
  ];
  home.packages = lib.attrValues {
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
