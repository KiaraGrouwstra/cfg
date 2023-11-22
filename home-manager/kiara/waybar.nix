{ pkgs, ... }:

{

  # https://github.com/Alexays/Waybar/wiki/Examples#cjbassis-configuration
  programs.waybar = {
    enable = true;
    settings = with (import ./commands.nix { pkgs = pkgs; }); {

      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [
          "hyprland/language"
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "memory"
          "cpu"
          "battery"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "tray"
        ];

        "custom/left-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/left-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-light" = {
          format = "";
          tooltip = false;
        };

        "hyprland/language" = {
          format = "{short}";
        };
        "hyprland/workspaces" = {
          active-only = true;
          disable-scroll = true;
          format = "{name} {windows}";
          format-window-separator = " ";
          window-rewrite-default = "";
          window-rewrite = {
            firefox = "";
            wezterm = "";
            codium = "󰨞";
            thunderbird = "󰇮";
            keepassxc = "";
            nautilus = "󰉋";
            signal = "󰭹";
          };
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            active = "";
            default = "";
          };
          on-click = "activate";
          on-scroll-up = "${hyprctl} dispatch workspace -1";
          on-scroll-down = "${hyprctl} dispatch workspace +1";
        };
        clock = {
          format = "{:%H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_down";
            on-scroll-down = "shift_up";
          };
        };
        pulseaudio = {
          format = "{icon} {volume:2}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 5;
          max-volume = 250;
          on-click = "${pamixer} -t";
          on-click-right = "${pavucontrol}";
          on-scroll-down = "${wpctl} set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%-";
          on-scroll-up   = "${wpctl} set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%+";
        };
        memory = {
          interval = 5;
          format = " {}%";
        };
        cpu = {
          interval = 5;
          format = "󱛟 {usage:2}%";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        disk = {
          interval = 5;
          format = "󱛟 {percentage_used:2}%";
          path = "/";
        };
        tray = {
          icon-size = 20;
        };
      };
    };

    style = ''
      * {
        font-size: 20px;
        font-family: monospace;
      }

      window#waybar {
        background: #292b2e;
        color: #fdf6e3;
      }

      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
        color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
        color: #292b2e;
        background: #1a1a1a;
      }

      #workspaces,
      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
        background: #1a1a1a;
      }

      #workspaces button {
        padding: 0 2px;
        color: #fdf6e3;
      }
      #workspaces button.focused {
        color: #268bd2;
      }
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }
      #workspaces button:hover {
        background: #1a1a1a;
        border: #1a1a1a;
        padding: 0 3px;
      }

      #pulseaudio {
        color: #268bd2;
      }
      #memory {
        color: #2aa198;
      }
      #cpu {
        color: #6c71c4;
      }
      #battery {
        color: #859900;
      }
      #disk {
        color: #b58900;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
        padding: 0 10px;
      }

      #workspaces button {
        padding: 0 0.5em;
        margin: 0.25em;
      }

      #window {
          border-radius: 20px;
          padding-left: 10px;
          padding-right: 10px;
      }

      #language {
          border-radius: 20px;
          padding-left: 10px;
          padding-right: 10px;
      }
    '';
  };

}
