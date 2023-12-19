{ pkgs, inputs, ... }:

let
  hyprland-contrib = inputs.hyprland-contrib.packages.${pkgs.system};
in
with pkgs; {
  waybar = "${waybar}/bin/waybar";
  notify-send = "${libnotify}/bin/notify-send";
  swaync = "${swaynotificationcenter}/bin/swaync";
  swaync-client = "${swaynotificationcenter}/bin/swaync-client";
  jq = "${jq}/bin/jq";
  swayidle = "${swayidle}/bin/swayidle";
  kitty = "${pkgs.kitty}/bin/kitty";
  kitten = "${pkgs.kitty}/bin/kitten";
  wezterm = "${wezterm}/bin/wezterm";
  wofi = "${wofi}/bin/wofi";
  rofi = "${rofi-wayland}/bin/rofi -i";
  rofi-systemd = "${rofi-systemd}/bin/.rofi-systemd-wrapped";
  rofimoji = "${rofimoji}/bin/rofimoji";
  ranger = "${ranger}/bin/ranger";
  nmtui = "${networkmanager}/bin/nmtui";
  swaylock = "${swaylock-effects}/bin/swaylock";
  swww = "${swww}/bin/swww";
  htop = "${htop}/bin/htop";
  wal = "${pywal}/bin/wal";
  nautilus = "${gnome.nautilus}/bin/nautilus";
  networkmanager_dmenu = "${networkmanager_dmenu}/bin/networkmanager_dmenu";
  cliphist = "${cliphist}/bin/cliphist";
  wl-copy = "${wl-clipboard}/bin/wl-copy";
  wl-paste = "${wl-clipboard}/bin/wl-paste";
  hyprctl = "${hyprland}/bin/hyprctl";
  light = "${light}/bin/light";
  playerctl = "${playerctl}/bin/playerctl";
  wpctl = "${wireplumber}/bin/wpctl";
  pamixer = "${pamixer}/bin/pamixer";
  pavucontrol = "${pavucontrol}/bin/pavucontrol";
  # terminal = "${wezterm}/bin/wezterm -e --always-new-process";
  terminal = "${pkgs.kitty}/bin/kitty";
  less = "${less}/bin/less";
  glow = "${glow}/bin/glow";
  lynx = "${lynx}/bin/lynx";
  visidata = "${visidata}/bin/visidata";
  kanshictl = "${kanshi}/bin/kanshictl";
  hyprpicker = "${hyprpicker}/bin/hyprpicker";
  hyprland-contrib = hyprland-contrib;
  grimblast = "XDG_SCREENSHOTS_DIR=\"$HOME/Pictures/Screenshots\" ${hyprland-contrib.grimblast}/bin/grimblast";
  webtorrent = "${nodePackages.webtorrent-cli}/bin/webtorrent";
  baobab = "${baobab}/bin/baobab";
  unfullscreen = "~/.config/hypr/scripts/unfullscreen";
}
