{pkgs, config, ...}: {
  home.packages = with pkgs; [
    exiftool
    ripdrag
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    # https://yazi-rs.github.io/docs/configuration/keymap
    # https://yazi-rs.github.io/docs/quick-start/#keybindings
    # https://github.com/sxyazi/yazi/blob/latest/yazi-config/preset/keymap.toml
    # keymap = {
    #   input.keymap = [
    #     { exec = "close"; on = [ "<C-q>" ]; }
    #     { exec = "close --submit"; on = [ "<Enter>" ]; }
    #     { exec = "escape"; on = [ "<Esc>" ]; }
    #     { exec = "backspace"; on = [ "<Backspace>" ]; }
    #   ];
    #   manager.keymap = [
    #     { exec = "escape"; on = [ "<Esc>" ]; }
    #     { exec = "quit"; on = [ "q" ]; }
    #     { exec = "close"; on = [ "<C-q>" ]; }
    #   ];
    # };
    # https://yazi-rs.github.io/docs/configuration/theme
    # https://github.com/sxyazi/yazi/blob/latest/yazi-config/preset/yazi.toml
    # theme = {
    #   filetype = {
    #     rules = [
    #       { fg = "#7AD9E5"; mime = "image/*"; }
    #       { fg = "#F3D398"; mime = "video/*"; }
    #       { fg = "#F3D398"; mime = "audio/*"; }
    #       { fg = "#CD9EFC"; mime = "application/x-bzip"; }
    #     ];
    #   };
    # };
    # https://yazi-rs.github.io/docs/configuration/yazi
    # https://github.com/sxyazi/yazi/blob/latest/yazi-config/preset/yazi.toml
    settings = with config.commands; {
      log = {
        enabled = false;
      };
      manager = {
        sort_dir_first = true;
        prepend_keymap = [
          # https://yazi-rs.github.io/docs/tips/#dropping-to-shell
          {
            on = ["<C-s>"];
            run = ''shell "$SHELL" --block --confirm'';
            desc = "Open shell here";
          }
          # https://yazi-rs.github.io/docs/tips/#smart-enter
          {
            on = ["l"];
            run = "plugin --sync smart-enter";
            desc = "Enter the child directory, or open the file";
          }
          # https://yazi-rs.github.io/docs/tips/#drag-and-drop
          {
            on = ["<C-n>"];
            run = ''
              shell '${ripdrag} "$@" -x 2>/dev/null &' --confirm
            '';
          }
          # https://yazi-rs.github.io/docs/tips/#selected-files-to-clipboard
          {
            on = ["y"];
            run = [
              "yank"
              ''
                shell --confirm 'for path in "$@"; do echo "file://$path"; done | ${wl-copy} -t text/uri-list'
              ''
            ];
          }
          # https://yazi-rs.github.io/docs/tips/#navigation-wraparound
          {
            on = ["k"];
            run = "plugin --sync arrow --args=-1";
          }
          {
            on = ["j"];
            run = "plugin --sync arrow --args=1";
          }
          # https://yazi-rs.github.io/docs/tips/#parent-arrow
          {
            on = ["K"];
            run = "plugin --sync parent-arrow --args=-1";
          }
          {
            on = ["J"];
            run = "plugin --sync parent-arrow --args=1";
          }
        ];
      };
      input = {
        prepend_keymap = [
          # https://yazi-rs.github.io/docs/tips/#close-input-by-esc
          {
            on = ["<Esc>"];
            run = "close";
            desc = "Cancel input";
          }
        ];
      };
    };
  };
}
