{pkgs, ...}:
# TODO: JIT'ify? (#152)
let
  commands = with pkgs; {
    nix = "${nix}/bin/nix";
    xdg-open = "${xdg-utils}/bin/xdg-open";
    tree = "${tree}/bin/tree";
    bat = "${bat}/bin/bat";
    pistol = "${pistol}/bin/pistol";
    eza = "${eza}/bin/eza";
    fzf = "${fzf}/bin/fzf";
    hexyl = "${hexyl}/bin/hexyl";
    viu = "${viu}/bin/viu";
    timg = "${timg}/bin/timg";
    systemctl = "${systemd}/bin/systemctl";
    alacritty = "${alacritty}/bin/alacritty";
    swaybg = "${swaybg}/bin/swaybg";
    dbus-update-activation-environment = "${dbus}/bin/dbus-update-activation-environment";
    tor-browser = "${tor-browser}/bin/tor-browser";
    kdeconnect-indicator = "${kdeconnect}/bin/kdeconnect-indicator";
    gnome-system-monitor = "${gnome.gnome-system-monitor}/bin/gnome-system-monitor";
    waybar = "${waybar}/bin/waybar";
    notify-send = "${libnotify}/bin/notify-send";
    swaync = "${swaynotificationcenter}/bin/swaync";
    swaync-client = "${swaynotificationcenter}/bin/swaync-client";
    jaq = "${jaq}/bin/jaq";
    swayidle = "${swayidle}/bin/swayidle";
    kitty = "${pkgs.kitty}/bin/kitty";
    kitten = "${pkgs.kitty}/bin/kitten";
    wezterm = "${wezterm}/bin/wezterm";
    wofi = "${wofi}/bin/wofi";
    rofi = "${rofi-wayland}/bin/rofi -i";
    rofi-systemd = "${rofi-systemd}/bin/.rofi-systemd-wrapped";
    rofimoji = "${rofimoji}/bin/rofimoji";
    gum = "${gum}/bin/gum";
    yazi = "${yazi}/bin/yazi";
    just = "${just}/bin/just";
    ripdrag = "${ripdrag}/bin/ripdrag";
    nmtui = "${networkmanager}/bin/nmtui";
    swaylock = "${swaylock-effects}/bin/swaylock";
    swww = "${swww}/bin/swww";
    btop = "${btop}/bin/btop";
    wallust = "${wallust}/bin/wallust";
    thunar = "${xfce.thunar}/bin/thunar";
    networkmanager_dmenu = "${networkmanager_dmenu}/bin/networkmanager_dmenu";
    cliphist = "${cliphist}/bin/cliphist";
    wl-copy = "${wl-clipboard}/bin/wl-copy";
    wl-paste = "${wl-clipboard}/bin/wl-paste";
    light = "${light}/bin/light";
    playerctl = "${playerctl}/bin/playerctl";
    wpctl = "${wireplumber}/bin/wpctl";
    pamixer = "${pamixer}/bin/pamixer";
    pavucontrol = "${pavucontrol}/bin/pavucontrol";
    terminal = "${wezterm}/bin/wezterm -e --always-new-process";
    # terminal = "${pkgs.kitty}/bin/kitty";
    less = "${less}/bin/less";
    glow = "${glow}/bin/glow";
    lynx = "${lynx}/bin/lynx";
    visidata = "${visidata}/bin/visidata";
    webtorrent = "${nodePackages.webtorrent-cli}/bin/webtorrent";
    keepassxc = "${keepassxc}/bin/keepassxc";
    firefox = "${firefox-bin}/bin/firefox";
    codium = "${vscodium}/bin/codium";
  };
in
  commands
  // (with commands;
    # command wrappers
      let
        inherit (pkgs) lib;
      in {
        # "curl" -> "nix run nixpkgs#curl"
        run = program: "${nix} run nixpkgs#${program}";
        # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui'"
        term = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}'";
        # "nmtui" -> "wezterm -e --always-new-process sh -c 'nmtui'; $SHELL"
        hold = args: "${wezterm} -e --always-new-process sh -c '${lib.escape ["'"] args}; $SHELL'";
        # "du-dust" -> "dust" -> "nix shell nixpkgs#du-dust --command dust"
        shell = name: cmd: "${nix} shell nixpkgs#${name} --command \"${lib.escape ["\""] cmd}\"";
      })
