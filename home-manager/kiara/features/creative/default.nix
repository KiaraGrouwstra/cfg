{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.creative;
in {
  options.toggles.creative.enable = mkEnableOption "creative";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## graphics
      imv

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
  };
}
