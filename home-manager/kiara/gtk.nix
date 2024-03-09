_: {
  gtk.enable = true;

  dconf.settings = {
    "org/gnome/evince/default" = {
      inverted-colors = true;
      show-sidebar = false;
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
