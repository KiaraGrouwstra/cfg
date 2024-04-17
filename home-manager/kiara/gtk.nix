_: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/gtk-2.0"
    ".config/gtk-3.0"
    ".config/gtk-4.0"
  ];

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
