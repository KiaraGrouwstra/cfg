{ pkgs, ... }:

{

  home.packages = with pkgs; [
    kanshi
  ];

  # monitor hot swapping: list by `hyprctl monitors`
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {

      lid_closed = {
        outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
        ];
      };

      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };

      home_office = {
        outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
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
