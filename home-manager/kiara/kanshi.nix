{ config, pkgs, ... }:

{

  # monitor hot swapping: list by `hyprctl monitors`
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            # scale = 1.1;
            status = "enable";
          }
        ];
      };

      home_office = {
        outputs = [
          {
            criteria = "Samsung Electric Company SAMSUNG";
            status = "enable";
            position = "0,0";
            mode = "1366x768@60Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      };

    };
  };

}
