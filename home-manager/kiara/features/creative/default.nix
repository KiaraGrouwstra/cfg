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
      libsForQt5.koko
      swayimg
      vimiv-qt
      oculante
      gwenview
      libsForQt5.pix
      gnome.eog
      imv
      gimp

      ## screenshots
      hyprpicker
      wayshot
      watershot
      slurp
      scrot
      grim
      peek
      wl-screenrec
      obs-studio
      imagemagick
      puppeteer-cli

      ## audio
      libsForQt5.kasts
      newsboat
      castget
      pamixer
      pavucontrol
      cava
      spotify-tui
      spotify-player
      deadbeef
      cmus
      musikcube
      ncmpcpp
      ffmpeg
      gnome.gnome-music

      ## video
      mpv
      vlc
      stremio  # add providers for content, e.g. https://torrentio.strem.fun/

      ## 3d printing
      prusa-slicer
      cura
      curaengine  # https://github.com/NixOS/nixpkgs/issues/281145
      freecad
      octoprint
      printrun
      rpi-imager

    ];
  };
}
