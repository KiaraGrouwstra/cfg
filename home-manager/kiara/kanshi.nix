{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    kanshi
  ];

  # monitor hot swapping: list by `hyprctl monitors`
  services.kanshi = {
    enable = true;
    systemdTarget = "${if config.wayland.windowManager.hyprland.enable then "hyprland" else "niri"}-session.target";

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

      internal = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
          {
            criteria = "HDMI-A-1";
            status = "disable";
          }
        ];
      };

      external = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
        ];
      };

      extend = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
          {
            criteria = "*";
            status = "enable";
          }
        ];
      };

    };
  };

}
