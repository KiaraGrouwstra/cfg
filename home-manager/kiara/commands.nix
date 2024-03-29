{pkgs, lib, inputs, config, ...}:
# TODO: JIT'ify? (#152)
let
  inherit (pkgs) system;
  commands = with pkgs; (lib.dryCommands (
    # key = binary name = package name
    (lib.listToAttrs
      (lib.lists.map
        lib.attrsFromPackage
        ((with config.programs; lib.lists.map (lib.getAttr "package") [
          # programs.<name>.package
          fzf
          waybar
          kitty
          wezterm
          wofi
          yazi
        ]) ++ [
          nix
          tree
          bat
          eza
          hexyl
          pistol
          viu
          timg
          jaq
          swayidle
          alacritty
          swaybg
          tor-browser
          rofimoji
          gum
          ripdrag
          just
          lf
          swww
          btop
          wallust
          networkmanager_dmenu
          cliphist
          light
          playerctl
          pamixer
          pavucontrol
          less
          glow
          lynx
          visidata
          baobab
          keepassxc
        ])
      )
      //
      # package name differs but binary name = key
      (with inputs; (with config.programs; lib.mapVals (lib.getAttr "package") {
        # programs.<name>.package
        inherit
          swaylock
          firefox
        ;
        codium = vscode;
      }) // {
        nmtui = networkmanager;
        notify-send = libnotify;
        xdg-open = xdg-utils;
        kdeconnect-indicator = kdeconnect;
        gnome-system-monitor = gnome.gnome-system-monitor;
        dbus-update-activation-environment = dbus;
        swaync = swaynotificationcenter;
        swaync-client = swaynotificationcenter;
        systemctl = systemd;
        kitten = pkgs.kitty;
        thunar = xfce.thunar;
        wl-copy = wl-clipboard;
        wl-paste = wl-clipboard;
        wpctl = wireplumber;
        webtorrent = nodePackages.webtorrent-cli;
        anyrun = anyrun.packages.${system}.anyrun;
        symbols = anyrun.packages.${system}.symbols;
      })
    )
  )
  //
  # misc: either using args, or key != package name.
  # in case of args, consider a [wrapping overlay/script](https://nixos.wiki/wiki/Wrappers_vs._Dotfiles).
  {
    rofi = "${config.programs.rofi.package}/bin/rofi -i";
    rofi-systemd = "${rofi-systemd}/bin/.rofi-systemd-wrapped";
    terminal = "${wezterm}/bin/wezterm -e --always-new-process";
    # terminal = "${pkgs.kitty}/bin/kitty";
  });
in
{
  # refactor imports to options/config to factor out arg noise
  options.commands = lib.mkOption {
      type = with lib.types; (attrsOf (either str (functionTo (either str (functionTo str)))));
      default = null;
      description = "binary reference to use throughout my config";
      example = { bash = "${pkgs.bash}/bin/bash"; };
    };
  config.commands = commands // (with commands; {
    # command wrappers
    # "curl" -> "nix run nixpkgs#curl"
    run = program: "${nix} run nixpkgs#${program}";
    # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui'"
    term = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}'";
    # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui'; $SHELL"
    hold = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}; $SHELL'";
    # "du-dust" -> "dust" -> "nix shell nixpkgs#du-dust --command dust"
    shell = name: cmd: "${nix} shell nixpkgs#${name} --command \"${lib.escape ["\""] cmd}\"";
  });
}
