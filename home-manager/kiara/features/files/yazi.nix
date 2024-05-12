{
  pkgs,
  config,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/yazi"
  ];

  home.packages = with pkgs; [
    exiftool
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    # https://yazi-rs.github.io/docs/configuration/keymap
    # https://yazi-rs.github.io/docs/quick-start/#keybindings
    # https://github.com/sxyazi/yazi/blob/latest/yazi-config/preset/keymap.toml
    keymap = with config.keyboard.vi; {
      input.keymap = [
        # https://yazi-rs.github.io/docs/tips/#close-input-by-esc
        {
          on = ["<Esc>"];
          run = "close";
          desc = "Cancel input";
        }
        {
          on = ["i"];
          run = "insert";
          desc = "Enter insert mode";
        }
        {
          on = ["a"];
          run = "insert --prepend";
          desc = "Enter prepend mode";
        }
        {
          on = ["I"];
          run = ["move -999" "insert"];
          desc = "Move to the BOL; and enter insert mode";
        }
        {
          on = ["A"];
          run = ["move 999" "insert --prepend"];
          desc = "Move to the EOL; and enter prepend mode";
        }
        {
          on = ["v"];
          run = "visual";
          desc = "Enter visual mode";
        }
        {
          on = ["V"];
          run = ["move -999" "visual" "move 999"];
          desc = "Enter visual mode and select all";
        }

        # Character-wise movement
        {
          on = [j];
          run = "move -1";
          desc = "Move back a character";
        }
        {
          on = [l];
          run = "move 1";
          desc = "Move forward a character";
        }
        {
          on = ["<Left>"];
          run = "move -1";
          desc = "Move back a character";
        }
        {
          on = ["<Right>"];
          run = "move 1";
          desc = "Move forward a character";
        }
        {
          on = ["<C-b>"];
          run = "move -1";
          desc = "Move back a character";
        }
        {
          on = ["<C-f>"];
          run = "move 1";
          desc = "Move forward a character";
        }

        # Word-wise movement
        {
          on = ["b"];
          run = "backward";
          desc = "Move back to the start of the current or previous word";
        }
        {
          on = ["w"];
          run = "forward";
          desc = "Move forward to the start of the next word";
        }
        {
          on = [e];
          run = "forward --end-of-word";
          desc = "Move forward to the end of the current or next word";
        }
        {
          on = ["<A-b>"];
          run = "backward";
          desc = "Move back to the start of the current or previous word";
        }
        {
          on = ["<A-f>"];
          run = "forward --end-of-word";
          desc = "Move forward to the end of the current or next word";
        }

        # Line-wise movement
        {
          on = ["<C-a>"];
          run = "move -999";
          desc = "Move to the BOL";
        }
        {
          on = ["<C-${e}>"];
          run = "move 999";
          desc = "Move to the EOL";
        }

        # Delete
        {
          on = ["<Backspace>"];
          run = "backspace";
          desc = "Delete the character before the cursor";
        }
        {
          on = ["<Delete>"];
          run = "backspace --under";
          desc = "Delete the character under the cursor";
        }
        {
          on = ["<C-${h}>"];
          run = "backspace";
          desc = "Delete the character before the cursor";
        }
        {
          on = ["<C-d>"];
          run = "backspace --under";
          desc = "Delete the character under the cursor";
        }

        # Kill
        {
          on = ["<C-u>"];
          run = "kill bol";
          desc = "Kill backwards to the BOL";
        }
        {
          on = ["<C-k>"];
          run = "kill eol";
          desc = "Kill forwards to the EOL";
        }
        {
          on = ["<C-w>"];
          run = "kill backward";
          desc = "Kill backwards to the start of the current word";
        }
        {
          on = ["<A-d>"];
          run = "kill forward";
          desc = "Kill forwards to the end of the current word";
        }

        # Cut/Yank/Paste
        {
          on = ["d"];
          run = "delete --cut";
          desc = "Cut the selected characters";
        }
        {
          on = ["D"];
          run = ["delete --cut" "move 999"];
          desc = "Cut until the EOL";
        }
        {
          on = ["c"];
          run = "delete --cut --insert";
          desc = "Cut the selected characters; and enter insert mode";
        }
        {
          on = ["C"];
          run = ["delete --cut --insert" "move 999"];
          desc = "Cut until the EOL; and enter insert mode";
        }
        {
          on = ["x"];
          run = ["delete --cut" "move 1 --in-operating"];
          desc = "Cut the current character";
        }
        {
          on = [y];
          run = "yank";
          desc = "Copy the selected characters";
        }
        {
          on = ["p"];
          run = "paste";
          desc = "Paste the copied characters after the cursor";
        }
        {
          on = ["P"];
          run = "paste --before";
          desc = "Paste the copied characters before the cursor";
        }

        # Undo/Redo
        {
          on = ["u"];
          run = "undo";
          desc = "Undo the last operation";
        }
        {
          on = ["<C-r>"];
          run = "redo";
          desc = "Redo the last operation";
        }
      ];
      manager.keymap = [
        # https://yazi-rs.github.io/docs/tips/#dropping-to-shell
        {
          on = ["<C-s>"];
          run = ''shell "$SHELL" --block --confirm'';
          desc = "Open shell here";
        }
        # https://yazi-rs.github.io/docs/tips/#drag-and-drop
        # {
        #   on = ["<C-n>"];
        #   run = ''
        #     shell '${ripdrag} "$@" -x 2>/dev/null &' --confirm
        #   '';
        # }
        # https://yazi-rs.github.io/docs/tips/#smart-enter
        {
          on = [l];
          run = "plugin --sync smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = ["<Right>"];
          run = "plugin --sync smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        # https://yazi-rs.github.io/docs/tips/#selected-files-to-clipboard
        {
          on = [y];
          run = with config.commands; [
            "yank"
            ''
              shell --confirm 'for path in "$@"; do echo "file://$path"; done | ${wl-copy} -t text/uri-list'
            ''
          ];
        }
        # https://yazi-rs.github.io/docs/tips/#navigation-wraparound
        {
          on = [k];
          run = "plugin --sync arrow --args=-1";
        }
        {
          on = ["<Up"];
          run = "plugin --sync arrow --args=-1";
        }
        {
          on = [j];
          run = "plugin --sync arrow --args=1";
        }
        {
          on = ["<Down"];
          run = "plugin --sync arrow --args=1";
        }
        {
          on = [K];
          run = "plugin --sync arrow --args=-5";
        }
        {
          on = [J];
          run = "plugin --sync arrow --args=5";
        }
        # skip confirm on delete
        {
          on = ["d"];
          run = "remove --force";
          desc = "Move the files to the trash";
        }
        {
          on = [h];
          run = "leave";
          desc = "Go back to the parent directory";
        }
        {
          on = ["<Left>"];
          run = "leave";
          desc = "Go back to the parent directory";
        }
        # { on = [ l ]; run = "enter"; desc = "Enter the child directory"; }
        {
          on = [H];
          run = "back";
          desc = "Go back to the previous directory";
        }
        {
          on = [L];
          run = "forward";
          desc = "Go forward to the next directory";
        }
        {
          on = ["<A-${k}>"];
          run = "seek -5";
          desc = "Seek up 5 units in the preview";
        }
        {
          on = ["<A-${j}>"];
          run = "seek 5";
          desc = "Seek down 5 units in the preview";
        }

        {
          on = [o];
          run = "open";
          desc = "Open the selected files";
        }
        {
          on = [O];
          run = "open --interactive";
          desc = "Open the selected files interactively";
        }
        {
          on = [y];
          run = "yank";
          desc = "Copy the selected files";
        }
        {
          on = [Y];
          run = "unyank";
          desc = "Cancel the yank status of files";
        }
        {
          on = ["<C-s>"];
          run = "search none";
          desc = "Cancel the ongoing search";
        }
      	{
          on = [ "<PageUp>" ];
          run = "arrow -100%";
          desc = "Move cursor up one page";
        }
      	{
          on = [ "<PageDown>" ];
          run = "arrow 100%";
          desc = "Move cursor down one page";
        }
        # Linemode
        {
          on = ["m" "n"];
          run = "linemode none";
          desc = "Set linemode to none";
        }

        # Copy
        {
          on = ["c" "n"];
          run = "copy name_without_ext";
          desc = "Copy the name of the file without the extension";
        }

        # Find
        {
          on = [n];
          run = "find_arrow";
          desc = "Go to next found file";
        }
        {
          on = [N];
          run = "find_arrow --previous";
          desc = "Go to previous found file";
        }
      ];
      tasks.keymap = [
        {
          on = [k];
          run = "arrow -1";
          desc = "Move cursor up";
        }
        {
          on = [j];
          run = "arrow 1";
          desc = "Move cursor down";
        }
      ];
      select.keymap = [
        {
          on = [k];
          run = "arrow -1";
          desc = "Move cursor up";
        }
        {
          on = [j];
          run = "arrow 1";
          desc = "Move cursor down";
        }
        {
          on = [K];
          run = "arrow -5";
          desc = "Move cursor up 5 lines";
        }
        {
          on = [J];
          run = "arrow 5";
          desc = "Move cursor down 5 lines";
        }
      ];
      completion.keymap = [
        {
          on = ["<A-${k}>"];
          run = "arrow -1";
          desc = "Move cursor up";
        }
        {
          on = ["<A-${j}>"];
          run = "arrow 1";
          desc = "Move cursor down";
        }
        {
          on = ["<C-p>"];
          run = "arrow -1";
          desc = "Move cursor up";
        }
        {
          on = ["<C-k>"];
          run = "arrow 1";
          desc = "Move cursor down";
        }
      ];
      help.keymap = [
        {
          on = [k];
          run = "arrow -1";
          desc = "Move cursor up";
        }
        {
          on = [j];
          run = "arrow 1";
          desc = "Move cursor down";
        }
        {
          on = [K];
          run = "arrow -5";
          desc = "Move cursor up 5 lines";
        }
        {
          on = [J];
          run = "arrow 5";
          desc = "Move cursor down 5 lines";
        }
      ];
    };
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
    settings = {
      log = {
        enabled = false;
      };
      manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
