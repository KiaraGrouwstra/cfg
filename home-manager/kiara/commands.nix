{ pkgs, ... }:

with pkgs; {
  waybar = "${waybar}/bin/waybar";
  notify-send = "${libnotify}/bin/notify-send";
  swaync = "${swaynotificationcenter}/bin/swaync";
  swaync-client = "${swaynotificationcenter}/bin/swaync-client";
  jq = "${jq}/bin/jq";
  swayidle = "${swayidle}/bin/swayidle";
  wezterm = "${wezterm}/bin/wezterm";
  wofi = "${wofi}/bin/wofi";
  rofi = "${rofi-wayland}/bin/rofi";
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
  terminal = "${wezterm}/bin/wezterm -e --always-new-process";
  less = "${less}/bin/less";
  glow = "${glow}/bin/glow";
  lynx = "${lynx}/bin/lynx";
  visidata = "${visidata}/bin/visidata";
  unfullscreen = "~/.config/hypr/scripts/unfullscreen";
}
