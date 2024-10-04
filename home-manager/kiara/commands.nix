{
  pkgs,
  lib,
  inputs,
  config,
  unstable,
  ...
}:
# TODO: JIT'ify? (#152)
let
  wrapSecrets = vars: pkg: (pkgs.writeShellScriptBin pkg.pname
    (lib.concatLines ((lib.mapAttrsToList (k: v: ''export ${k}="$(cat ${config.sops.secrets."${v}".path})"'') vars)
        ++ ["${lib.getExe pkg} $@"])));
  inherit (pkgs) system;
  binaries = (
    lib.listToAttrs
    (
      lib.lists.map
      # key = binary name = package name
      lib.attrsFromPackage ((lib.attrValues {
          inherit
            (pkgs)
            curl
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
            nvimpager
            swayidle
            alacritty
            swaybg
            tor-browser
            gum
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
            keepassxc
            libnotify
            local-ai
            anyrun
            symbols
            typos-lsp
            swaynotificationcenter
            visidata
            ;
        })
        ++ [
          unstable.xwayland-satellite
          pkgs.xfce.thunar
          (wrapSecrets {GITHUB_TOKEN = "github-pat";} pkgs.nixpkgs-review)
        ]
        ++ (lib.attrVals (lib.attrNames (import ../../packages.nix {inherit inputs lib pkgs;})) pkgs)
        ++ lib.attrValues
        {
          inherit
            (pkgs.nodePackages)
            typescript
            vscode-langservers-extracted
            bash-language-server
            typescript-language-server
            ;
          inherit (pkgs.python312Packages) python-lsp-server;
        }
        # programs.<name>.package
        ++ (
          lib.catAttrs "package" (lib.attrValues {
            inherit
              (config.programs)
              fzf
              waybar
              kitty
              wezterm
              yazi
              swaylock
              firefox
              vscode
              zsh
              ;
          })
        ))
    )
    //
    # package name differs but binary name = key
    ((let
        inherit (config.programs) kitty helix;
      in
        lib.mapVals (lib.getAttr "package") {
          # programs.<name>.package
          kitten = kitty;
          hx = helix;
        })
      // {
        nmtui = pkgs.networkmanager;
        xdg-open = pkgs.xdg-utils;
        kdeconnect-indicator = pkgs.kdeconnect;
        dbus-update-activation-environment = pkgs.dbus;
        swaync-client = pkgs.swaynotificationcenter;
        systemctl = pkgs.systemd;
        wl-copy = pkgs.wl-clipboard;
        wl-paste = pkgs.wl-clipboard;
        wpctl = pkgs.wireplumber;
        clangd = pkgs.clang-tools;
        exo-open = pkgs.xfce.exo;
        btm = pkgs.bottom;
      })
  );
  commands = let
    inherit (pkgs) rofi-systemd;
    wezterm = config.programs.wezterm.package;
  in
    lib.dryCommands binaries
    //
    # misc: either using args, or key != package name.
    # in case of args, consider a [wrapping overlay/script](https://wiki.nixos.org/wiki/Wrappers_vs._Dotfiles).
    {
      rofi = "${config.programs.rofi.package}/bin/rofi -i";
      rofi-systemd = "${rofi-systemd}/bin/.rofi-systemd-wrapped";
      terminal = "${wezterm}/bin/wezterm -e --always-new-process";
      # terminal = "${pkgs.kitty}/bin/kitty";
    };
in {
  # refactor imports to options/config to factor out arg noise
  options.commands = lib.mkOption {
    type = let inherit (lib.types) either str functionTo attrsOf; in attrsOf (either str (functionTo str));
    default = null;
    description = "binary reference to use throughout my config";
    example = {bash = "${pkgs.bash}/bin/bash";};
  };
  config.home.packages = lib.attrValues binaries;
  config.commands =
    commands
    // (
      let
        inherit (commands) nix wezterm zsh;
        shell = zsh;
      in
        {
          # command wrappers
          # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui'"
          term = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}'";
          term' = args: ''${wezterm} -e --always-new-process sh -c "${lib.escape ["\""] args}"'';
          # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui; $SHELL'"
          hold = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}; ${shell}'";
          hold' = args: ''${wezterm} -e --always-new-process sh -c "${lib.escape ["\""] args}; ${shell}"'';
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
          "powersupply"
        ] (program: "${nix} run nixpkgs#${program}"))
    );
}
