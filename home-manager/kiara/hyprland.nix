{ pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    # systemd service needed for kanshi
    systemd.enable = true;
    settings = let
      rofi-systemd = "${pkgs.rofi-systemd}/bin/.rofi-systemd-wrapped";
      rofimoji = "${pkgs.rofimoji}/bin/rofimoji";
      wallpaper_dir = "~/Pictures/wallpapers/";
    in {
      # See https://wiki.hyprland.org/Configuring/Monitors/
      # monitor = ", preferred, auto, auto";
      monitor = ", preferred, auto, auto, mirror, HDMI-A-1";

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = [
        "waybar" # & signal-desktop & thunderbird & firefox # & codium & keepassxc

        # screen sharing
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # notifications
        # "mako"
        "dunst"
        # "swaync"

        # Lock screen after idling
        "swayidle -w timeout 900 'swaylock -i $(swww query | sed \"s/^.*image: //g\") -f'"

        # wallpapers
        "swww init"
        "wal -i `cat ~/.cache/wal/wal`"

        "wl-paste --type text --watch cliphist store" #Stores only text data
        "wl-paste --type image --watch cliphist store" #Stores only image data
      ];

      # Some default env vars.
      env = "XCURSOR_SIZE,24";

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
          kb_layout = "us";
          # kb_variant = "";
          # kb_model = "";
          kb_options = "caps:escape";
          # kb_rules = "";

          follow_mouse = 1;

          touchpad = {
              natural_scroll = true;
          };

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
          # See https://wiki.hyprland.org/Configuring/Variables/#general for more

          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "dwindle";

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          # allow_tearing = false;
      };

      decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/#decoration for more

          rounding = 40;

          blur = {
              enabled = true;
              size = 3;
              passes = 1;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
          enabled = true;

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];

      };

      dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to SUPER + P in the keybinds section below
          preserve_split = true; # you probably want this
      };

      master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true;
      };

      gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true;
      };

      misc = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          # force_default_wallpaper = -1; # Set to 0 to disable the anime mascot wallpapers
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      # "device:epic-mouse-v1" = {
      #     sensitivity = -0.5;
      # };

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      windowrule = [
        "rounding 40,^(kitty)|(wezterm)$"
        "opacity 0.9 override 0.7 override,.*" # transparent when inactive
        "opacity 0.8 override 0.5 override,^(kitty)|(wezterm)$" # transparent when inactive
      ];
      windowrulev2 = [
        "opacity 0.8 0.5, floating:1"
        "bordercolor rgb(000000) rgb(080808), fullscreen:1" # bordercolor when fullscreen
      ];

      bindr = "SUPER, Super_L, exec, pkill rofi || rofi -show drun -show-icons";

      # Move/resize windows with SUPER + LMB/RMB and dragging
      bindm = [
        # ", mouse:272, movewindow";  # triggers on any click :(
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindel = [

        # Audio
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl stop"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        # Brightness
        ", XF86MonBrightnessDown, exec, light -U 1"
        ", XF86MonBrightnessUp, exec, light -A 1"

      ];

      bindl = "SUPER SHIFT, L, exec, sleep 1 && hyprctl dispatch dpms off";

      bind = [

        # switch wallpaper
        "SUPER, G, exec, find ${wallpaper_dir} | sort -R | tail -n 1 | while read -r img ; do swww img --transition-type random $img; wal -i $img; done"
        "SHIFT SUPER, G, exec, ls ${wallpaper_dir} | rofi -dmenu -i -p 'Wallpapers' | while read -r img ; do swww img --transition-type random ${wallpaper_dir}$img; wal -i ${wallpaper_dir}$img; done"

        # See https://wiki.hyprland.org/Configuring/Binds/ for more
        "SUPER, E, exec, wezterm"
        "SUPER, Q, killactive,"
        "ALT, F4, killactive,"
        "SUPER, M, exit,"
        "SUPER, X, exec, nautilus"
        "SUPER, H, togglefloating,"

        "SUPER, P, pseudo," # dwindle
        "SUPER, J, togglesplit," # dwindle

        # Move focus with SUPER + wasd
        "SUPER, W, movefocus, u"
        "SUPER, A, movefocus, l"
        "SUPER, S, movefocus, d"
        "SUPER, D, movefocus, r"

        # Move focus with SUPER + arrows
        "SUPER, Up, movefocus, u"
        "SUPER, Left, movefocus, l"
        "SUPER, Down, movefocus, d"
        "SUPER, Right, movefocus, r"

        # Move focus with SUPER ALT/SHIFT + wasd
        "SUPER ALT, W, movewindow, u"
        "SUPER ALT, A, movewindow, l"
        "SUPER ALT, S, movewindow, d"
        "SUPER ALT, D, movewindow, r"
        "SUPER SHIFT, W, movewindow, u"
        "SUPER SHIFT, A, movewindow, l"
        "SUPER SHIFT, S, movewindow, d"
        "SUPER SHIFT, D, movewindow, r"
        # "SUPER ALT, W, swapwindow, u"
        # "SUPER ALT, A, swapwindow, l"
        # "SUPER ALT, S, swapwindow, d"
        # "SUPER ALT, D, swapwindow, r"

        # Move focus with SUPER ALT/SHIFT + arrows
        "SUPER ALT, Up, movewindow, u"
        "SUPER ALT, Left, movewindow, l"
        "SUPER ALT, Down, movewindow, d"
        "SUPER ALT, Right, movewindow, r"
        "SUPER SHIFT, Up, movewindow, u"
        "SUPER SHIFT, Left, movewindow, l"
        "SUPER SHIFT, Down, movewindow, d"
        "SUPER SHIFT, Right, movewindow, r"

        # # Move window with SUPER + arrows -- doesn't work
        # "SUPER, Up, moveactive,0 -10"
        # "SUPER, Left, moveactive,-10 0"
        # "SUPER, Down, moveactive,0 10"
        # "SUPER, Right, moveactive,10 0"

        # switch master orientation with ctrl+super+wasd
        # not working yet, see https://wiki.hyprland.org/Configuring/Master-Layout/
        # "SUPER_CTRL, W, orientationtop"
        # "SUPER_CTRL, A, orientationleft"
        # "SUPER_CTRL, S, orientationbottom"
        # "SUPER_CTRL, D, orientationright"

        # Switch workspaces with SUPER + [0-9]
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        # Switch workspaces with SUPER + PageUp / PageDown (Z / C)
        "SUPER, Page_Up, workspace, -1"
        "SUPER, Page_Down, workspace, +1"
        "SUPER, Z, workspace, -1"
        "SUPER, C, workspace, +1"

        # Move active window to a workspace with SUPER + SHIFT + [0-9]
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        # Move to workspaces with SUPER + ALT + PageUp / PageDown (Z / C)
        "SUPER ALT, Page_Up, movetoworkspace, -1"
        "SUPER ALT, Page_Down, movetoworkspace, +1"
        "SUPER ALT, Z, movetoworkspace, -1"
        "SUPER ALT, C, movetoworkspace, +1"

        # Move to workspaces with SUPER + SHIFT + PageUp / PageDown (Z / C)
        "SUPER SHIFT, Page_Up, movetoworkspace, -1"
        "SUPER SHIFT, Page_Down, movetoworkspace, +1"
        "SUPER SHIFT, Z, movetoworkspace, -1"
        "SUPER SHIFT, C, movetoworkspace, +1"

        # Move active window to a workspace with SUPER + ALT + SHIFT + [0-9]
        "SUPER ALT SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER ALT SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER ALT SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER ALT SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER ALT SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER ALT SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER ALT SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER ALT SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER ALT SHIFT, 9, movetoworkspacesilent, 9"
        "SUPER ALT SHIFT, 0, movetoworkspacesilent, 10"

        # Move to workspaces with SUPER + ALT + SHIFT + PageUp / PageDown (Z / C)
        "SUPER ALT SHIFT, Page_Up, movetoworkspacesilent, -1"
        "SUPER ALT SHIFT, Page_Down, movetoworkspacesilent, +1"
        "SUPER ALT SHIFT, Z, movetoworkspacesilent, -1"
        "SUPER ALT SHIFT, C, movetoworkspacesilent, +1"

        # Scroll through existing workspaces with SUPER + scroll
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # to switch between windows in a floating workspace
        "ALT, Tab, cyclenext,"          # change focus to another window
        "ALT, Tab, bringactivetotop,"   # bring it to the top
        "SUPER, Tab, cyclenext,"          # change focus to another window
        "SUPER, Tab, bringactivetotop,"   # bring it to the top
        # reverse switching
        "ALT_SHIFT, Tab, cyclenext, prev"
        "ALT_SHIFT, Tab, bringactivetotop,"
        "SUPER SHIFT, Tab, cyclenext, prev"
        "SUPER SHIFT, Tab, bringactivetotop,"
        "SUPER_ALT, Tab, cyclenext, prev"
        "SUPER_ALT, Tab, bringactivetotop,"

        # bind type emoji using MS keyboard's emoji key
        # "SUPER_SHIFT_CTRL_ALT, Space, exec, rofi -show emoji"
        "SUPER_SHIFT_CTRL_ALT, Space, exec, ${rofimoji} -f emoji"

        "SUPER, N, exec, systemctl suspend"
        # ", PowerDown, exec, systemctl suspend"
        # ", PowerOff, exec, systemctl suspend"

        "SUPER, F, fullscreen, 1"
        "SUPER ALT, F, fullscreen, 0"

        "SUPER, O, exec, hyprctl dispatch toggleopaque"
        "SUPER, K, exec, hyprctl dispatch exit"

        "SUPER, F1, exec, ~/.config/hypr/scripts/gamemode"
        "SUPER, F3, exec, ${./fontpreview.sh}"
        "SUPER, F5, exec, sudo python ~/.config/hypr/scripts/usbreset.py path /dev/bus/usb/001/002"
        "SUPER, I, exec, networkmanager_dmenu"
        "SUPER, U, exec, ~/.config/rofi/power.sh"
        "SUPER, Y, exec, ~/.config/rofi/keepassxc.sh"
        "SUPER, T, exec, ${rofi-systemd}"
        "SUPER, B, exec, ${rofimoji} -f latin-1_supplement -a copy"
        "CTRL_ALT, Delete, exec, gnome-system-monitor"

        # set $menu bemenu-run

        # screenshots
        # region: to clipboard
        ", Print, exec, ~/.config/hypr/scripts/screenshot rc"
        # region: to file
        "SUPER, Print, exec, ~/.config/hypr/scripts/screenshot rf"
        # region: interactive
        "CTRL, Print, exec, ~/.config/hypr/scripts/screenshot ri"
        # screen: to clipboard
        "SHIFT, Print, exec, ~/.config/hypr/scripts/screenshot sc"
        # screen: to file
        "SUPER SHIFT, Print, exec, ~/.config/hypr/scripts/screenshot sf"
        # screen: interactive
        "CTRL SHIFT, Print, exec, ~/.config/hypr/scripts/screenshot si"
        # pixel
        "ALT, Print, exec, ~/.config/hypr/scripts/screenshot p"

        # clipboard
        "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # SUPER L - Locks immediately, SUPERSHIFT L Turns monitors off (while locked)
        "SUPER, L, exec, swaylock -i $(swww query | sed 's/^.*image: //g')"

      ];

      # UNUSED:

      # exec dbus-sway-environment
      # exec configure-gtk

      # swapnext
      # pin
      # centerwindow

      # resizewindowpixel
      # movewindowpixel
      # focuswindow
      # focusmonitor
      # splitratio

      # movecursortocorner
      # movecursor

      # forcerendererreload
      # focusurgentorlast
      # focuscurrentorlast

      # workspaceopt
      # renameworkspace
      # movecurrentworkspacetomonitor
      # moveworkspacetomonitor
      # swapactiveworkspaces
      # togglespecialworkspace

      # togglegroup
      # changegroupactive
      # lockgroups
      # lockactivegroup
      # moveintogroup
      # moveoutofgroup
      # movewindoworgroup
      # movegroupwindow

    };

    # submaps
    extraConfig = ''
      # sets repeatable binds for resizing the active window
      bind = SUPER, R, submap, resize
      submap = resize
      binde = , up, resizeactive, 0 -10
      binde = , left, resizeactive, -10 0
      binde = , down, resizeactive, 0 10
      binde = , right, resizeactive, 10 0
      bind = , escape, submap, reset
      submap = reset
    '';
  };

}
