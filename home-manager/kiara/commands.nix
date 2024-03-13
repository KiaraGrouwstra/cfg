{pkgs, lib, ...}: {
  # refactor imports to options/config to factor out arg noise
  # options.commands = attrsetOption (lib.mkOption {
  #     type = lib.types.str;
  #     default = null;
  #     description = "binary reference to use throughout my config";
  #     example = "${pkgs.bash}/bin/bash";
  #   });
  # TODO: JIT'ify? (#152)
  config.commands = let
    # { rofi = pkgs.rofi-wayland; } -> { rofi = "${pkgs.rofi-wayland}/bin/rofi"; }
    dryCommands = lib.mapAttrs (binaryName: package: "${package}/bin/${binaryName}");
  in with pkgs; (dryCommands
    (
      # key = binary name = package name
      (lib.listToAttrs
        (lib.lists.map
          # packages have paths like "/nix/store/*-bash-5.2p26",
          # so grab package names from between the dashes to use as key
          (pkg: let
              name = lib.concatStringsSep "-" (lib.init (lib.tail (lib.splitString "-" (builtins.toPath pkg))));
            in
            { inherit name; value = pkg; }
          )

          [
            # nix
            tree
            bat
            # pistol
            # eza
            # fzf
            # hexyl
            # viu
            # timg
            # waybar
            # jaq
            # swayidle
            # pkgs.kitty
            # wezterm
            # anyrun
            # wofi
            # rofimoji
            # gum
            # lf
            # swww
            # btop
            # wallust
            # networkmanager_dmenu
            # cliphist
            # light
            # playerctl
            # pamixer
            # pavucontrol
            # less
            # glow
            # lynx
            # visidata
            # baobab
            # keepassxc
          ]
        )
        # //
        # # package name differs but binary name = key
        # {
        #   nmtui = networkmanager;
        #   notify-send = libnotify;
        #   swaync = swaynotificationcenter;
        #   swaync-client = swaynotificationcenter;
        #   kitten = pkgs.kitty;
        #   swaylock = swaylock-effects;
        #   thunar = xfce.thunar;
        #   wl-copy = wl-clipboard;
        #   wl-paste = wl-clipboard;
        #   wpctl = wireplumber;
        #   webtorrent = nodePackages.webtorrent-cli;
        #   firefox = firefox-bin;
        #   codium = vscodium;
        # }
      )
    )
    # //
    # # misc: either using args, or key != package name.
    # # in case of args, consider a [wrapping overlay/script](https://nixos.wiki/wiki/Wrappers_vs._Dotfiles).
    # {
    #   rofi = "${rofi-wayland}/bin/rofi -i";
    #   rofi-systemd = "${rofi-systemd}/bin/.rofi-systemd-wrapped";
    #   terminal = "${wezterm}/bin/wezterm -e --always-new-process";
    # }
  );
}
