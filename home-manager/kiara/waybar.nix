{config, ...}: {
  home.persistence."/persist/home/kiara".directories = [
    # ".config/waybar"
  ];

  # https://github.com/Alexays/Waybar/wiki/Examples#cjbassis-configuration
  programs.waybar = {
    enable = true;
    settings = let
      inherit (config.commands) term gnome-system-monitor pavucontrol pamixer powersupply zfxtop wpctl btop nmtui playerctl hold just dust alacritty networkmanager_dmenu toggle anyrun swaync-client;
    in {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [
          "custom/start"
          "custom/right-arrow-dark"
          "mpris"
        ];
        modules-center = ["custom/left-arrow-dark" "clock" "custom/right-arrow-dark"];
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

        "custom/start" = {
          format = "";
          on-click = "${toggle anyrun} --plugins libapplications.so";
          on-click-right = "${swaync-client} --toggle-panel";
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
          on-click = gnome-system-monitor;
          on-click-right = term btop;
        };
        cpu = {
          interval = 5;
          format = "󱛟  {usage:2}%";
          on-click = "${alacritty} -e ${zfxtop}";
          on-click-right = term btop;
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
          on-click = hold "${just} -f ${../../Justfile} gc";
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
    '';
  };
}
