{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
# TODO: JIT'ify? (#152)
let
  inherit (pkgs) system;
  binaries = with pkgs; (
    lib.listToAttrs
    (
      lib.lists.map
      # key = binary name = package name
      lib.attrsFromPackage ([
          git
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
          gum
          nvimpager
          ripdrag
          just
          wallust
          networkmanager_dmenu
          cliphist
          light
          playerctl
          pamixer
          pavucontrol
          nixd
          nil
          shfmt
          alejandra
          less
          glow
          lynx # lesspipe
          visidata
          keepassxc
          libnotify
          gnome.gnome-system-monitor
          swaynotificationcenter
          xfce.thunar
        ]
        ++ lib.attrValues
        {
          inherit
            (nodePackages)
            webtorrent-cli
            vscode-css-languageserver-bin
            bash-language-server
            typescript-language-server
            ;
        }
        ++ (with config.programs;
          lib.lists.map (lib.getAttr "package") [
            # programs.<name>.package
            fzf
            waybar
            kitty
            wezterm
            yazi
            swaylock
            firefox
            vscode
            helix
          ]))
    )
    //
    # package name differs but binary name = key
    ((with config.programs;
        lib.mapVals (lib.getAttr "package") {
          # programs.<name>.package
          kitten = kitty;
        })
      // {
        nmtui = networkmanager;
        xdg-open = xdg-utils;
        kdeconnect-indicator = kdeconnect;
        dbus-update-activation-environment = dbus;
        swaync-client = swaynotificationcenter;
        systemctl = systemd;
        wl-copy = wl-clipboard;
        wl-paste = wl-clipboard;
        wpctl = wireplumber;
        clangd = clang-tools;
        inherit
          (nodePackages)
          typescript
          ;
      }
      // (with inputs; {
        inherit (anyrun.packages.${system}) anyrun;
        inherit (anyrun.packages.${system}) symbols;
      }))
  );
  commands = with pkgs;
    lib.dryCommands binaries
    //
    # misc: either using args, or key != package name.
    # in case of args, consider a [wrapping overlay/script](https://nixos.wiki/wiki/Wrappers_vs._Dotfiles).
    {
      rofi = "${config.programs.rofi.package}/bin/rofi -i";
      rofi-systemd = "${rofi-systemd}/bin/.rofi-systemd-wrapped";
      terminal = "${wezterm}/bin/wezterm -e --always-new-process";
      # terminal = "${pkgs.kitty}/bin/kitty";
    };
in {
  # refactor imports to options/config to factor out arg noise
  options.commands = lib.mkOption {
    type = with lib.types; attrsOf (either str (functionTo str));
    default = null;
    description = "binary reference to use throughout my config";
    example = {bash = "${pkgs.bash}/bin/bash";};
  };
  config.home.packages = lib.attrValues binaries;
  config.commands =
    commands
    // (
      with commands;
        {
          # command wrappers
          # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui'"
          term = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}'";
          # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui; $SHELL'"
          hold = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}; $SHELL'";
          # "/bin/wofi" -> "(pidof wofi && kill -9 $(pidof wofi)) || wofi"
          toggle = program: "(pidof ${builtins.baseNameOf program} && kill -9 $(pidof ${builtins.baseNameOf program})) || ${program}";
        }
        # JIT: binary name != package name
        # "du-dust" -> "dust" -> "nix shell nixpkgs#du-dust --command dust"
        // (lib.mapAttrs (cmd: pkg: "${nix} shell nixpkgs#${pkg} --command \"${lib.escape ["\""] cmd}\"") {
          dust = "du-dust";
        })
        # JIT: binary name = package name
        # "curl" -> "nix run nixpkgs#curl"
        // (lib.genAttrs [
          "zfxtop"
          "btop"
          "powersupply"
        ] (program: "${nix} run nixpkgs#${program}"))
    );
}
