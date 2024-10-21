{pkgs, ...}: {
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
      {
        profile = {
          name = "lid_closed";
          # exec = [];
          outputs = [
            {
              criteria = "HDMI-A-1";
              status = "enable";
            }
          ];
        };
      }

      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }

      {
        profile = {
          name = "home";
          outputs = [
            {
              criteria = "HDMI-A-1";
              status = "enable";
              mode = "1366x768@59.790Hz";
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "1920x1200@60Hz";
              position = "1366,0";
            }
          ];
        };
      }

      {
        profile = {
          name = "extend";
          outputs = [
            {
              criteria = "*";
              status = "enable";
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "enable";
              mode = "1920x1200@60Hz";
            }
          ];
        };
      }

      {
        profile = {
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
        };
      }
    ];
  };
}
