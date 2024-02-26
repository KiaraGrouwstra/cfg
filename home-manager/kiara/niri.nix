{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    wayland
    qt6.qtwayland
    swaybg
    # in case of non-parsing configs
    alacritty
    fuzzel
  ];
  programs.niri.config =
    with (import ./commands.nix {inherit pkgs inputs;});
    with inputs.niri.kdl;
  let
    terminal = keybind: args: spawn keybind (["wezterm" "-e" "--always-new-process"] ++ args);
    run = program: ["${nix}" "run" "nixpkgs#${program}"];
    binds =
      {
        suffixes,
        prefixes,
        substitutions ? {},
      }: let
        replacer = lib.replaceStrings (lib.attrNames substitutions) (lib.attrValues substitutions);
        format = prefix: suffix:
          inputs.niri.kdl.plain "${prefix.key}+${suffix.key}" [
            (let
              actual-suffix =
                if lib.isList suffix.action
                then {
                  action = lib.head suffix.action;
                  args = lib.tail suffix.action;
                }
                else {
                  inherit (suffix) action;
                  args = [];
                };
            in
              inputs.niri.kdl.leaf (replacer "${prefix.action}-${actual-suffix.action}") actual-suffix.args)
          ];
        pairs = attrs: fn:
          lib.concatMap (key:
            fn {
              inherit key;
              action = attrs.${key};
            }) (lib.attrNames attrs);
      in
        pairs prefixes (prefix: pairs suffixes (suffix: [(format prefix suffix)]));
    bind = keys: action: args:
      plain keys [
        (leaf action args)
      ];
    spawn = lib.flip bind "spawn";
    simple = keys: action: bind keys action [];
  in serialize.nodes [

    (plain "input" [
        (plain "keyboard" [
            (plain "xkb" [
                # You can set rules, model, layout, variant and options.
                # For more information, see xkeyboard-config(7).
                (leaf "layout" ["us,nl"])
                (leaf "options" ["caps:escape"])
            ])

            # You can set the keyboard repeat parameters. The defaults match wlroots and sway.
            # Delay is in milliseconds before the repeat starts. Rate is in characters per second.
            # (leaf "repeat-delay" [600])
            # (leaf "repeat-rate" [25])

            # Niri can remember the keyboard layout globally (the default) or per-window.
            # - "global" - layout change is global for all windows.
            # - "window" - layout is tracked for each window individually.
            (leaf "track-layout" ["global"])
        ])

        # Next sections include libinput settings.
        # Omitting settings disables them, or leaves them at their default values.
        (plain "touchpad" [
            (plain-leaf "tap")
            # (plain-leaf "dwt")
            # (plain-leaf "dwtp")
            (plain-leaf "natural-scroll")
            # (leaf "accel-speed" [0.2])
            # (leaf "accel-profile" ["flat"])
            # (leaf "tap-button-map] ["left-middle-right"])
        ])

        (plain "mouse" [
            # (plain-leaf "natural-scroll")
            (leaf "accel-speed" [0.2])
            # (leaf "accel-profile" ["flat"])
        ])

        (plain "trackpoint" [
            (plain-leaf "natural-scroll")
            (leaf "accel-speed" [0.2])
            # (leaf "accel-profile" ["flat"])
        ])

        (plain "tablet" [
            # Set the name of the output (see below) which the tablet will map to.
            # If this is unset or the output doesn't exist, the tablet maps to one of the
            # existing outputs.
            (leaf "map-to-output" ["eDP-1"])
        ])

        # By default, niri will take over the power button to make it sleep
        # instead of power off.
        # Uncomment this if you would like to configure the power button elsewhere
        # (i.e. logind.conf).
        # (plain-leaf "disable-power-key-handling")
    ])

    # You can configure outputs by their name, which you can find
    # by running `niri msg outputs` while inside a niri instance.
    # The built-in laptop monitor is usually called "eDP-1".
    # (node "output" ["eDP-1"] [
    #     # Uncomment this line to disable this output.
    #     # (plain-leaf "off")

    #     # Scale is a floating-point number, but at the moment only integer values work.
    #     (leaf "scale" [2.0])

    #     # Transform allows to rotate the output counter-clockwise, valid values are:
    #     # normal, 90, 180, 270, flipped, flipped-90, flipped-180 and flipped-270.
    #     (leaf "transform" ["normal"])

    #     # Resolution and, optionally, refresh rate of the output.
    #     # The format is "<width>x<height>" or "<width>x<height>@<refresh rate>".
    #     # If the refresh rate is omitted, niri will pick the highest refresh rate
    #     # for the resolution.
    #     # If the mode is omitted altogether or is invalid, niri will pick one automatically.
    #     # Run `niri msg outputs` while inside a niri instance to list all outputs and their modes.
    #     (leaf "mode" "1920x1080@120.030")

    #     # Position of the output in the global coordinate space.
    #     # This affects directional monitor actions like "focus-monitor-left", and cursor movement.
    #     # The cursor can only move between directly adjacent outputs.
    #     # Output scale has to be taken into account for positioning:
    #     # outputs are sized in logical, or scaled, pixels.
    #     # For example, a 3840*2160 output with scale 2.0 will have a logical size of 1920×1080,
    #     # so to put another output directly adjacent to it on the right, set its x to 1920.
    #     # It the position is unset or results in an overlap, the output is instead placed
    #     # automatically.
    #     (leaf "position" ["x=1280" "y=0"])
    # ])

    (plain "layout" [
        # By default focus ring and border are rendered as a solid background rectangle
        # behind windows. That is, they will show up through semitransparent windows.
        # This is because windows using client-side decorations can have an arbitrary shape.
        #
        # If you don't like that, you should uncomment `prefer-no-csd` below.
        # Niri will draw focus ring and border *around* windows that agree to omit their
        # client-side decorations.

        # You can change how the focus ring looks.
        (plain "focus-ring" [
            # Uncomment this line to disable the focus ring.
            # (plain-leaf "off")

            # How many logical pixels the ring extends out from the windows.
            (leaf "width" [4])

            # Colors can be set in a variety of ways:
            # - CSS named colors: "red"
            # - RGB hex: "#rgb", "#rgba", "#rrggbb", "#rrggbbaa"
            # - CSS-like notation: "rgb(255, 127, 0)", rgba(), hsl() and a few others.

            # Color of the ring on the active monitor.
            # (leaf "active-color" ["#ef9f76ee"])

            # Color of the ring on inactive monitors.
            # (leaf "inactive-color" ["#595959aa"])

            # You can also use gradients. They take precedence over solid colors.
            # Gradients are rendered the same as CSS linear-gradient(angle, from, to).
            # Colors can be set in a variety of ways here:
            # - CSS named colors: from="red"
            # - RGB hex: from="#rgb", from="#rgba", from="#rrggbb", from="#rrggbbaa"
            # - CSS-like notation: from="rgb(255, 127, 0)", rgba(), hsl() and a few others.
            # The angle is the same as in linear-gradient, and is optional,
            # defaulting to 180 (top-to-bottom gradient).
            # You can use any CSS linear-gradient tool on the web to set these up.
            # (plain "active-gradient" [
            #   (leaf "from" ["#80c8ff"])
            #   (leaf "to" ["#bbddff"])
            #   (leaf "angle" [45])
            # ])

            # You can also color the gradient relative to the entire view
            # of the workspace, rather than relative to just the window itself.
            # To do that, set relative-to="workspace-view".
            # (plain "inactive-gradient" [
            #   (leaf "from" ["#505050"])
            #   (leaf "to" ["#808080"])
            #   (leaf "angle" [45])
            #   (leaf "relative-to" ["workspace-view"])
            # ])

        ])

        # You can also add a border. It's similar to the focus ring, but always visible.
        (plain "border" [
            # The settings are the same as for the focus ring.
            # If you enable the border, you probably want to disable the focus ring.
            (plain-leaf "off")

            (leaf "width" [4])
            # (leaf "active-color" ["#ffc87fff"])
            # (leaf "inactive-color" ["#505050ff"])
        ])

        # You can customize the widths that "switch-preset-column-width" (Mod+R) toggles between.
        (plain "preset-column-widths" [
            # Proportion sets the width as a fraction of the output width, taking gaps into account.
            # For example, you can perfectly fit four windows sized "proportion 0.25" on an output.
            # The default preset widths are 1/3, 1/2 and 2/3 of the output.
            (leaf "proportion" [0.33333])
            (leaf "proportion" [0.5])
            (leaf "proportion" [0.66667])

            # Fixed sets the width in logical pixels exactly.
            # (leaf "fixed" [1920])
        ])

        # You can change the default width of the new windows.
        # (plain "default-column-width" [ (leaf "proportion" [0.5]) ])
        # If you leave the brackets empty, the windows themselves will decide their initial width.
        (plain "default-column-width" [])

        # Set gaps around windows in logical pixels.
        (leaf "gaps" [16])

        # Struts shrink the area occupied by windows, similarly to layer-shell panels.
        # You can think of them as a kind of outer gaps. They are set in logical pixels.
        # Left and right struts will cause the next window to the side to always be visible.
        # Top and bottom struts will simply add outer gaps in addition to the area occupied by
        # layer-shell panels and regular gaps.
        (plain "struts" [
            (leaf "left" [64])
            (leaf "right" [64])
            # (leaf "top" [64])
            # (leaf "bottom" [64])
        ])

        # When to center a column when changing focus, options are:
        # - "never", default behavior, focusing an off-screen column will keep at the left
        #   or right edge of the screen.
        # - "on-overflow", focusing a column will center it if it doesn't fit
        #   together with the previously focused column.
        # - "always", the focused column will always be centered.
        (leaf "center-focused-column" ["never"])
    ])

    # Add lines like this to spawn processes at startup.
    # Note that running niri as a session supports xdg-desktop-autostart,
    # which may be more convenient to use.

    (leaf "spawn-at-startup" ["swaybg" "-m" "fill" "-i" "/home/kiara/Pictures/wallpaper"])
    (leaf "spawn-at-startup" ["wallust" "run" "`cat ~/.cache/wal/wal`"])

    (leaf "spawn-at-startup" ["waybar"])

    (leaf "spawn-at-startup" ["kdeconnect-cli"])

    # screen sharing
    (leaf "spawn-at-startup" ["dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"])

    # Lock screen after idling
    # spawn-at-startup "swayidle" "-w" "timeout" "900" "'swaylock -f'"

    (leaf "spawn-at-startup" ["wl-paste" "--type" "text" "--watch" "cliphist" "store"]) # Stores only text data
    (leaf "spawn-at-startup" ["wl-paste" "--type" "image" "--watch" "cliphist" "store"]) # Stores only image data

    # You can override environment variables for processes spawned by niri.
    (plain "environment" [
        # Set a variable like this:
        (leaf "QT_QPA_PLATFORM" ["wayland"])

        # Remove a variable by using null as the value:
        # (leaf "DISPLAY" [null])
    ])

    (plain "cursor" [
        # Change the theme and size of the cursor as well as set the
        # `XCURSOR_THEME` and `XCURSOR_SIZE` env variables.
        # (leaf "xcursor-theme" ["default"])
        (leaf "xcursor-size" [24])
    ])

    # Uncomment this line to ask the clients to omit their client-side decorations if possible.
    # If the client will specifically ask for CSD, the request will be honored.
    # Additionally, clients will be informed that they are tiled, removing some rounded corners.
    # (plain-leaf "prefer-no-csd")
    # this option makes some terminals less ugly, but clashes with vscode :(

    # You can change the path where screenshots are saved.
    # A ~ at the front will be expanded to the home directory.
    # The path is formatted with strftime(3) to give you the screenshot date and time.
    (leaf "screenshot-path" ["~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"])

    # You can also set this to null to disable saving screenshots to disk.
    # (leaf "screenshot-path" ["null"])

    # Settings for the "Important Hotkeys" overlay.
    (plain "hotkey-overlay" [
        # Uncomment this line if you don't want to see the hotkey help at niri startup.
        (plain-leaf "skip-at-startup")
    ])


    # Animation settings.
    (plain "animations" [
        # Uncomment to turn off all animations.
        # (plain-leaf "off")

        # Slow down all animations by this factor. Values below 1 speed them up instead.
        # (leaf "slowdown" [3.0])

        # You can configure all individual animations.
        # Available settings are the same for all of them:
        # - off disables the animation.
        # - duration-ms sets the duration of the animation in milliseconds.
        # - curve sets the easing curve. Currently, available curves
        #   are "ease-out-cubic" and "ease-out-expo".

        # Animation when switching workspaces up and down,
        # including after the touchpad gesture.
        (plain "workspace-switch" [
            # (plain-leaf "off")
            # (leaf "duration-ms" [250])
            (leaf "curve" ["ease-out-cubic"])
        ])

        # All horizontal camera view movement:
        # - When a window off-screen is focused and the camera scrolls to it.
        # - When a new window appears off-screen and the camera scrolls to it.
        # - When a window resizes bigger and the camera scrolls to show it in full.
        # - And so on.
        (plain "horizontal-view-movement" [
            # (plain-leaf "off")
            # (leaf "duration-ms" [250])
            (leaf "curve" ["ease-out-cubic"])
        ])

        # Window opening animation. Note that this one has different defaults.
        (plain "window-open" [
            # (plain-leaf "off")
            # (leaf "duration-ms" [150])
            (leaf "curve" ["ease-out-cubic"])
        ])

        # Config parse error and new default config creation notification
        # open/close animation.
        (plain "config-notification-open-close" [
            # (plain-leaf "off")
            # (leaf "duration-ms" [250])
            (leaf "curve" ["ease-out-cubic"])
        ])
    ])

    # Window rules let you adjust behavior for individual windows.
    # They are processed in order of appearance in this file.
    # plain ("window-rule" [
    #     # Match directives control which windows this rule will apply to.
    #     # You can match by app-id and by title.
    #     # The window must match all properties of the match directive.
    #     (leaf "match" [{ app-id="org.myapp.MyApp"; title="My Cool App"; }])

    #     # There can be multiple match directives. A window must match any one
    #     # of the rule's match directives.
    #     #
    #     # If there are no match directives, any window will match the rule.
    #     (leaf "match" [{ title = "Second App"; }])

    #     # You can also add exclude directives which have the same properties.
    #     # If a window matches any exclude directive, it won't match this rule.
    #     #
    #     # Both app-id and title are regular expressions.
    #     # Raw KDL strings are helpful here.
    #     (leaf "exclude" [{ app-id = ''r#"\.unwanted\."#''; }])

    #     # Here are the properties that you can set on a window rule.
    #     # You can override the default column width.
    #     (plain "default-column-width" [ (leaf "proportion" [0.75]) ])

    #     # You can set the output that this window will initially open on.
    #     # If such an output does not exist, it will open on the currently
    #     # focused output as usual.
    #     (leaf "open-on-output" ["eDP-1"])

    #     # Make this window open as a maximized column.
    #     (leaf "open-maximized" [true])

    #     # Make this window open fullscreen.
    #     (leaf "open-fullscreen" [true])
    #     # You can also set this to false to prevent a window from opening fullscreen.
    #     (leaf "open-fullscreen" [false])
    # ])

    # Here's a useful example. Work around WezTerm's initial configure bug
    # by setting an empty default-column-width.
    # (plain "window-rule" [
    #     # This regular expression is intentionally made as specific as possible,
    #     # since this is the default config, and we want no false positives.
    #     # You can get away with just app-id="wezterm" if you want.
    #     # The regular expression can match anywhere in the string.
    #     (leaf "match" [{ app-id = ''r#"^org\.wezfurlong\.wezterm$"#''; }])
    #     (plain "default-column-width" [])
    # ])

    (plain "binds" [
        # Keys consist of modifiers separated by + signs, followed by an XKB key name
        # in the end. To find an XKB name for a particular key, you may use a program
        # like wev.
        #
        # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
        # when running as a winit window.
        #
        # Most actions that you can bind here can also be invoked programmatically with
        # `niri msg action do-something`.
        #
        # Most actions that you can bind here can also be invoked programmatically with
        # `niri msg action do-something`.

        (spawn "Mod+T" ["wezterm"])

        # You can also use a shell:
        # (spawn "Mod+T" ["bash" "-c" "notify-send hello && exec alacritty"])

        (spawn "XF86AudioRaiseVolume" ["wpctl" "set-volume" "-l" "2.0" "@DEFAULT_AUDIO_SINK@" "5%+"])
        (spawn "XF86AudioLowerVolume" ["wpctl" "set-volume" "-l" "2.0" "@DEFAULT_AUDIO_SINK@" "5%-"])
        (spawn "XF86AudioMute" ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"])
        (spawn "XF86AudioPlay" ["playerctl" "play-pause"])
        (spawn "XF86AudioStop" ["playerctl" "stop"])
        (spawn "XF86AudioPrev" ["playerctl" "previous"])
        (spawn "XF86AudioNext" ["playerctl" "next"])
        (spawn "XF86MonBrightnessDown" ["light" "-U" "1"])
        (spawn "XF86MonBrightnessUp" ["light" "-A" "1"])

        (simple "Mod+Q" "close-window")
        (simple "Alt+F4" "close-window")

        (binds {
          prefixes = {
            "Mod" = "focus";
            "Mod+Shift" = "move";
            "Mod+Alt" = "move";
            "Mod+Ctrl" = "focus-monitor";
            "Mod+Shift+Ctrl" = "move-column-to-monitor";
            "Mod+Shift+Ctrl+Alt" = "move-workspace-to-monitor";
          };
          suffixes = {
            # right hand
            Left = "column-left";
            Down = "window-down";
            Up = "window-up";
            Right = "column-right";
            # left hand
            S = "column-left";
            X = "window-down";
            Z = "window-up";
            D = "column-right";
          };
          substitutions = {
            monitor-column = "monitor";
            monitor-window = "monitor";
          };
        })

        (binds {
          prefixes = {
            "Mod" = "focus-column";
            "Mod+Shift" = "move-column-to";
          };
          suffixes = {
            Home = "first";
            End = "last";
          };
        })

        (binds {
          prefixes = {
            "Mod" = "focus-workspace";
            "Mod+Shift" = "move-column-to-workspace";
            "Mod+Alt" = "move-column-to-workspace";
            "Mod+Ctrl" = "move-workspace";
          };
          suffixes = {
            # right hand
            Page_Up = "up";
            Page_Down = "down";
            # left hand
            A = "up";
            F = "down";
          };
        })

        # You can refer to workspaces by index. However, keep in mind that
        # niri is a dynamic workspace system, so these commands are kind of
        # "best effort". Trying to refer to a workspace index bigger than
        # the current workspace count will instead refer to the bottommost
        # (empty) workspace.
        #
        # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # will all refer to the 3rd workspace.
        (binds {
          suffixes = lib.listToAttrs (lib.lists.map (n: {
            name = toString n;
            value = ["workspace" n];
          }) (lib.range 1 9));
          prefixes = {
            "Mod" = "focus";
            "Mod+Shift" = "move-column-to";
          };
        })

        (simple "Mod+Comma" "consume-window-into-column")
        (simple "Mod+Period" "expel-window-from-column")
        (simple "Mod+BracketLeft" "consume-or-expel-window-left")
        (simple "Mod+BracketRight" "consume-or-expel-window-right")

        (simple "Mod+R" "switch-preset-column-width")
        (simple "Mod+G" "maximize-column")
        (simple "Mod+Shift+G" "fullscreen-window")
        (simple "Mod+C" "center-column")

        # Finer width adjustments.
        # This command can also:
        # * set width in pixels: "1000"
        # * adjust width in pixels: "-5" or "+5"
        # * set width as a percentage of screen width: "25%"
        # * adjust width as a percentage of screen width: "-10%" or "+10%"
        # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # set-column-width "100" will make the column occupy 200 physical screen pixels.
        (bind "Mod+Minus" "set-column-width" ["-10%"])
        (bind "Mod+Equal" "set-column-width" ["+10%"])

        # Finer height adjustments when in column with other windows.
        (bind "Mod+Shift+Minus" "set-window-height" ["-10%"])
        (bind "Mod+Shift+Equal" "set-window-height" ["+10%"])

        # Actions to switch layouts.
        # Note: if you uncomment these, make sure you do NOT have
        # a matching layout switch hotkey configured in xkb options above.
        # Having both at once on the same hotkey will break the switching,
        # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # Mod+Space       { switch-layout "next"])
        # Mod+Shift+Space { switch-layout "prev"])

        (simple "Print" "screenshot")
        (simple "Ctrl+Print" "screenshot-screen")
        (simple "Alt+Print" "screenshot-window")

        (simple "Mod+Shift+H" "power-off-monitors")

        # This debug bind will tint all surfaces green, unless they are being
        # directly scanned out. It's therefore useful to check if direct scanout
        # is working.
        (simple "Mod+Shift+Ctrl+T" "toggle-debug-tint")

        # switch wallpaper
        (spawn "Mod+M" ["random-wallpaper.sh"])
        (terminal "Shift+Mod+M" ["pick-wallpaper.sh"])

        (spawn "Mod+W" ["firefox"])
        (spawn "Mod+V" ["codium"])
        (spawn "Mod+E" ["nautilus" "Downloads/"])
        (terminal "Mod+Shift+E" ["lf" "/home/kiara/Downloads/"])
        (terminal "Mod+Shift+Ctrl+Alt+Space" ["pick-character.sh" ./scripts/emoji.txt])
        (spawn "Mod+N" ["systemctl" "hibernate"])
        (simple "Mod+K" "quit")
        (terminal "Mod+F3" ["fontpreview.sh"])

        # Mod-/, kinda like Mod-?, shows a list of important hotkeys.
        (simple "Mod+Slash" "show-hotkey-overlay")

        (terminal "Mod+F9" ["main-menu.sh"])
        (terminal "Mod+I" ["nmtui"])
        (spawn "Mod+Shift+I" ["networkmanager_dmenu"])
        (terminal "Mod+U" ["power.sh"])
        (spawn "Mod+P" ["/home/kiara/.config/rofi/displays.sh"])
        (spawn "Mod+Y" ["/home/kiara/.config/rofi/keepassxc.sh" "-d" "~/Nextcloud/keepass.kdbx"])
        (spawn "Mod+B" ["anyrun" "--plugins" "libsymbols.so"])
        (spawn "Ctrl+Alt+Delete" ["gnome-system-monitor"])
        (spawn "Ctrl+Shift+Escape" (["alacritty" "-e"] ++ run "zfxtop"))
        (spawn "Mod+L" ["swaylock"])
        (spawn "Alt+Space" ["swaync-client" "--close-latest"])
        (spawn "Mod+Escape" ["swaync-client" "--close-all"])
        (spawn "Mod+Grave" ["swaync-client" "--toggle-panel"])

        (spawn "Mod+Space" ["anyrun.sh"])
        (terminal "Shift+Mod+Space" ["jit.sh"])
        (spawn "Ctrl+Mod+Space" ["wofi.sh"])
        (spawn "Alt+Mod+Space" ["rofi.sh"])
        (spawn "Mod+J" ["anyrun.sh"])
        (terminal "Shift+Mod+J" ["jit.sh"])
        (spawn "Ctrl+Mod+J" ["wofi.sh"])
        (spawn "Alt+Mod+J" ["rofi.sh"])
    ])

    # Settings for debugging. Not meant for normal use.
    # These can change or stop working at any point with little notice.
    (plain "debug" [
        # Make niri take over its DBus services even if it's not running as a session.
        # Useful for testing screen recording changes without having to relogin.
        # The main niri instance will *not* currently take back the services; so you will
        # need to relogin in the end.
        # (plain-leaf "dbus-interfaces-in-non-session-instances")

        # Wait until every frame is done rendering before handing it over to DRM.
        # (plain-leaf "wait-for-frame-completion-before-queueing")

        # Enable direct scanout into overlay planes.
        # May cause frame drops during some animations on some hardware.
        # (plain-leaf "enable-overlay-planes")

        # Disable the use of the cursor plane.
        # The cursor will be rendered together with the rest of the frame.
        # (plain-leaf "disable-cursor-plane")

        # Override the DRM device that niri will use for all rendering.
        # (leaf "render-drm-device" ["/dev/dri/renderD129"])

        # Enable the color-transformations capability of the Smithay renderer.
        # May cause a slight decrease in rendering performance.
        # (plain-leaf "enable-color-transformations-capability")
    ])

  ];
}
