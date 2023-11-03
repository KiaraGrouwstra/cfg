{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    gnomeExtensions.paperwm
  ];

  dconf.settings = {

    "org/gnome/shell" = {
      enabled-extensions = [
        "paperwm@hedning:matrix.org"
      ];
    };

    "org/gnome/shell/extensions/paperwm" = {
      use-default-background = true;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = ["<Super>BackSpace" "<Super>q"];
      switch-left = ["<Super>a" "<Super>Left"];
      switch-right = ["<Super>d" "<Super>Right"];
      switch-up = ["<Super>w" "<Super>Up"];
      switch-down = ["<Super>s" "<Super>Down"];
      switch-monitor-left = ["<Shift><Super>Left" "<Shift><Super>a"];
      switch-monitor-right = ["<Shift><Super>Right" "<Shift><Super>d"];
      move-left = ["<Control><Super>comma" "<Shift><Super>comma" "<Control><Super>Left" "<Control><Super>a" "<Alt><Super>a"];
      move-right = ["<Control><Super>period" "<Shift><Super>period" "<Control><Super>Right" "<Control><Super>d" "<Alt><Super>d"];
      move-monitor-left = ["<Shift><Control><Super>Left" "<Shift><Control><Super>a" "<Shift><Alt><Super>a"];
      move-monitor-right = ["<Shift><Control><Super>Right" "<Shift><Control><Super>d" "<Shift><Alt><Super>d"];
      move-up-workspace = ["<Control><Super>Page_Up" "<Alt><Super>Page_Up"];
      move-down-workspace = ["<Control><Super>Page_Down" "<Alt><Super>Page_Down"];
    };

  };

}
