{
  config,
  lib,
  unstable,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    # ".config/waybar"
  ];

  # https://github.com/Alexays/Waybar/wiki/Examples#cjbassis-configuration
  programs.waybar = {
    enable = true;
    package = unstable.waybar;
    settings = let
      inherit (config.commands) term pavucontrol pamixer powersupply btm wpctl nmtui playerctl hold just dust networkmanager_dmenu toggle anyrun swaync-client bluetuith;
      niri = lib.getExe config.programs.niri.package;
    in {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [
          "custom/start"
          "custom/right-arrow-dark"
          "niri/workspaces"
          # "niri/window"
          "mpris"
        ];
        modules-center = ["custom/left-arrow-dark" "clock" "custom/right-arrow-dark"];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "bluetooth"
          "memory"
          "cpu"
          "battery"
          "disk"
          "custom/left-arrow-light"
          "network"
          "niri/language"
          "custom/left-arrow-dark"
          "tray"
        ];

        "niri/language" = {
          format = "{shortDescription}";
          on-click = "${niri} msg action switch-layout next";
          on-click-right = "${niri} msg action switch-layout prev";
        };

        "niri/workspaces" = {
          all-outputs = false;
          format = "{icon}";
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
        };

        "niri/window" = {
          separate-outputs = true;
          icon = true;
          format = "";
          rewrite = {};
        };

        "custom/start" = {
          format = "";
          on-click = "${toggle anyrun} --plugins libapplications.so";
          on-click-right = "${swaync-client} --toggle-panel";
          on-scroll-up = "${niri} msg action focus-workspace-up";
          on-scroll-down = "${niri} msg action focus-workspace-down";
        };
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

        mpris = {
          format = "{player_icon} {status_icon} {dynamic}";
          format-playing = "{player_icon} {status_icon} {dynamic}";
          format-paused = "{player_icon} {status_icon} <i>{dynamic}</i>";
          format-stopped = "{player_icon} {status_icon} <i>{dynamic}</i>";
          dynamic-len = 30;
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
          on-scroll-down = "${playerctl} next";
          on-scroll-up = "${playerctl} previous";
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
          on-click = networkmanager_dmenu;
          on-click-right = term nmtui;
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
        bluetooth = {
          format = " {num_connections}";
          tooltip-format = "{device_alias}: {status}";
          on-click = hold bluetuith;
          on-click-right = hold bluetuith;
        };
        pulseaudio = {
          format = "{icon}   {volume:2}%";
          format-bluetooth = "{icon}   {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphones = "";
            default = ["" ""];
          };
          scroll-step = 5;
          max-volume = 250;
          on-click = "${pamixer} -t";
          on-click-right = pavucontrol;
          on-scroll-down = "${wpctl} set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%-";
          on-scroll-up = "${wpctl} set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%+";
        };
        memory = {
          interval = 5;
          format = "  {}%";
          on-click = term btm;
        };
        cpu = {
          interval = 5;
          format = "󱛟  {usage:2}%";
          on-click = term btm;
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󱘖 {capacity}%";
          format-icons = ["" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          on-click = term powersupply;
        };
        disk = {
          interval = 5;
          format = "󱛟  {percentage_used:2}%";
          path = "/";
          on-click = hold "${just} -f ${../../justfile} gc";
          on-click-right = hold dust;
        };
        tray = {icon-size = 20;};
      };
    };

    # GTK_DEBUG=interactive waybar
    style = ''
      * {
        font-size: 20px;
        font-family: "FiraCode Nerd Font";
      }

      window#waybar {
        background: #292b2e;
        color: #fdf6e3;
      }

      #custom-start {
        color: #6666aa;
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

      #clock,
      #bluetooth,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
        background: #1a1a1a;
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

      #network.disconnected {
        color: #ff0000;
      }

      #workspaces button {
        padding: 0 2px;
        color: #9d9683;
      }
      #workspaces button.focused {
        color: #ea999c;
      }
      #workspaces button.urgent {
        background-color: red;
      }
      #workspaces button:hover {
        background: #1a1a1a;
        border: #1a1a1a;
        box-shadow: inherit;
        text-shadow: inherit;
      }
      #bluetooth {
        color: DarkRed;
      }
    '';
  };
}
