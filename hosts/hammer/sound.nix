{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.sound;
in {
  options.toggles.sound.enable = mkEnableOption "sound";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };
  };
}
