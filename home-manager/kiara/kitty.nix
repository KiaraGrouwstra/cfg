{pkgs, ...}: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/kitty"
  ];
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    settings = {
      close_on_child_death = true; # yes
      confirm_os_window_close = 0;
      shell_integration = "enabled";
      terminal = ".";
      editor = ".";
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 15;
    };
  };
}
