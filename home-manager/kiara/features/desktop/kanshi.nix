{
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kanshi
  ];
  # monitor hot swapping: list by `niri msg outputs`
  services.kanshi = {
    enable = true;
    # no process seems to start with niri-session.target.
    # workaround: `(kanshi &) && kanshictl switch external`
    systemdTarget = "graphical-session.target";
    settings = [

      { profile = {
        name = "lid_closed";
        # exec = [];
        outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
        ];
      }; }

      { profile = {
        name = "undocked";
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }; }

      { profile = {
        name = "external";
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
      }; }

      { profile = {
        name = "extend";
        outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }; }

    ];
  };
}
