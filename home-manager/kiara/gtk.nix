{ pkgs, ... }:

{
  # If I can't dance to it, it's not my revolution. - Emma Goldman
  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    theme = {
      package = pkgs.palenight-theme;
      name = "palenight";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
      switch-applications = ["<Super>Tab"];
      switch-applications-backward = ["<Super><Alt>Tab"];
    };

    "org/gnome/nautilus/icon-view" = {
      captions = ["size" "none" "none"];
    };

    "org/gnome/evince/default" = {
      inverted-colors = true;
      show-sidebar = false;
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.wezfurlong.wezterm.desktop"
        "firefox.desktop"
        "thunderbird.desktop"
        "signal-desktop.desktop"
        "codium.desktop"
        "org.keepassxc.KeePassXC.desktop"
        "element-desktop.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "caps:escape"
      ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/session" = {
      idle-delay = 900;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-battery-timeout = 1200;
    };

    # [microsoft keyboard](https://unix.stackexchange.com/a/714224)
    "org/gnome/shell/extensions/emoji-copy" = {
      emoji-keybinding = ["<Shift><Ctrl><Alt><Super>space"];
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };

  };

}
