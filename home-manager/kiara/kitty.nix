{ config, pkgs, ... }:

let
  kitty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.kitty.package}/bin/kitty -1 "$@"
  '';
in {
  home = {
    packages = [ kitty-xterm ];
    sessionVariables = { TERMINAL = "kitty -1"; };
  };

  programs.kitty = {
    enable = true;
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
