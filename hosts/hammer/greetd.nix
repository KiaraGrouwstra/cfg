{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.greetd;
in {
  options.toggles.greetd.enable = mkEnableOption "greetd";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.greetd = {
      enable = true;
      restart = false;
      settings = rec {
        initial_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd niri --greeting 'welcome back'";
          user = "kiara";
        };
        default_session = initial_session;
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
