{ pkgs, lib, ... }:

{
  gtk.enable = true;

  dconf.settings = {

    "org/gnome/desktop/wm/keybindings" = {
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Super><Alt>Tab" ];
    };

    "org/gnome/nautilus/icon-view" = { captions = [ "size" "none" "none" ]; };

    "org/gnome/evince/default" = {
      inverted-colors = true;
      show-sidebar = false;
    };

    "org/gnome/shell" = {
      # ls ~/.local/share/applications/
      favorite-apps = lib.lists.map (_: _ + ".desktop") [
        "org.gnome.Nautilus"
        "wezterm"
        "mercury-browser"
        "firefox"
        "thunderbird"
        "signal-desktop"
        "sublime"
        "codium"
        "org.keepassxc.KeePassXC"
        "element-desktop"
      ];
    };

    "org/gnome/desktop/interface" = { show-battery-percentage = true; };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "terminate:ctrl_alt_bksp" "caps:escape" ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/session" = { idle-delay = 900; };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-battery-timeout = 1200;
    };

    # [microsoft keyboard](https://unix.stackexchange.com/a/714224)
    "org/gnome/shell/extensions/emoji-copy" = {
      emoji-keybinding = [ "<Shift><Ctrl><Alt><Super>space" ];
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

  };

}
