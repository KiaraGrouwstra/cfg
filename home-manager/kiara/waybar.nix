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
          "custom/right-arrow-dark"
          "mpris"
        ];
        modules-center = [
          "custom/left-arrow-dark"
          "clock"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "memory"
          "cpu"
          "battery"
          "disk"
          "custom/left-arrow-light"
          "network"
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
          active-only = false;
          disable-scroll = true;
          format = "{icon}";
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
            "1" = "壱";
            "2" = "弐";
            "3" = "参";
            "4" = "肆";
            "5" = "伍";
            "6" = "陸";
            "7" = "柒";
            "8" = "捌";
            "9" = "玖";
            "10" = "拾";
            default = "";
          };
          persistent-workspaces = {
            "*" = [ 1 2 3 4 5 6 7 8 9 10 ];
          };
          on-click = "activate";
          on-scroll-up = "${hyprctl} dispatch workspace -1";
          on-scroll-down = "${hyprctl} dispatch workspace +1";
        };
        mpris = {
          format = "{player_icon} {status_icon} {dynamic}";
          format-playing = "{player_icon} {status_icon} {dynamic}";
          format-paused = "{player_icon} {status_icon} <i>{dynamic}</i>";
          format-stopped = "{player_icon} {status_icon} <i>{dynamic}</i>";
          dynamic-len = 35;
          player-icons = {
            default = "";
            mpv = "󰝚";
            firefox = "";
          };
          status-icons = {
            playing = "󰐊";
            paused = "󰏤";
            stopped = "󰓛";
          };
        };
        network = {
          interface = "wlo1";
          format = "{ifname}";
          format-wifi = " ";
          format-ethernet = "󰈀 ";
          format-linked = "󱘖 ";
          format-disconnected = "󰣽 ";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "${networkmanager_dmenu}";
          on-click-right = "${unfullscreen} && ${terminal} ${nmtui}";
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
          format = "{icon}   {volume:2}%";
          format-bluetooth = "{icon}   {volume}%";
          format-muted = "󰝟";
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
          format = "  {}%";
        };
        cpu = {
          interval = 5;
          format = "󱛟  {usage:2}%";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
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
          format = "󱛟  {percentage_used:2}%";
          path = "/";
        };
        tray = {
          icon-size = 20;
        };
      };
    };

    # GTK_DEBUG=interactive waybar
    style = ''
      * {
        font-size: 20px;
        font-family: mono-space;
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
        color: #9d9683;
      }
      #workspaces button.active {
        color: #ea999c;
      }
      #workspaces button.urgent {
        background-color: red;
      }
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
      }
      #workspaces button:hover {
        background: #1a1a1a;
        border: #1a1a1a;
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

      #mpris{
          font-family: regular;
      }
    '';
  };

}
