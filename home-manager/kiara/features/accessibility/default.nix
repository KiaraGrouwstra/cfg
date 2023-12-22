{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.accessibility;
in {
  options.toggles.accessibility.enable = mkEnableOption "accessibility";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## mobile
      kdeconnect
      android-tools
      wvkbd
      cage

      ## speech / TTS
      speechd
      espeak-classic
      piper-tts
      yasr
      orca
      openai-whisper

    ];

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

  };
}
