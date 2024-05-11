{
  lib,
  config,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/helix"
  ];

  home.sessionVariables.COLORTERM = "truecolor";

  programs.helix = {
    enable = true;
    # https://docs.helix-editor.com/configuration.html
    settings = {
      theme = lib.mkForce "base16_transparent";
      editor = {
        auto-save = true;
        # line-number = "relative";
        soft-wrap.enable = true;
        lsp.display-messages = true;
        file-picker.hidden = false;
        whitespace.render = "all";
        color-modes = true;
        indent-guides.render = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys = with config.keyboard.vi; {
        normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          space.x = ":buffer-close";
          esc = ["collapse_selection" "keep_primary_selection"];
          "A-m" = "toggle_comments";
          "A-${d}" = "page_up";
          "A-${f}" = "page_down";
          "x" = "select_regex";
          "s" = "extend_line_below";
          "S" = "extend_to_line_bounds";
          "${h}" = "move_char_left";
          "${j}" = "move_visual_line_down";
          "${k}" = "move_visual_line_up";
          "${l}" = "move_char_right";
          "${e}" = "move_next_word_end";
          "${E}" = "move_next_long_word_end";
          "g" = {
            "${e}" = "goto_last_line";
            "${h}" = "goto_line_start";
            "${l}" = "goto_line_end";
            "${y}" = "goto_type_definition";
            "${n}" = "goto_next_buffer";
            "${j}" = "move_line_up";
            "${k}" = "move_line_down";
          };
          "${o}" = "open_below";
          "${O}" = "open_above";
          # "A-l" = "expand_selection";
          # "A-k" = "select_next_sibling";
          # "A-h" = "move_parent_node_end";
          # "[" = {
          #   "${e}" = "goto_prev_entry";
          # };
          # "]" = {
          #   "${e}" = "goto_next_entry";
          # };
          "${n}" = "search_next";
          "${N}" = "search_prev";
          "${y}" = "yank";
          "${J}" = "join_selections";
          # "A-${J}" = "join_selections_space";
          "${K}" = "keep_selections";
          # "A-${K}" = "remove_selections";
          # "esc" = "normal_mode";
          "C-b" = "page_up";
          "C-f" = "page_down";
          # "C-u" = "page_cursor_half_up";
          # "C-d" = "page_cursor_half_down";
          "C-w" = {
            "${h}" = "jump_view_left";
            "${j}" = "jump_view_down";
            "${k}" = "jump_view_up";
            "${l}" = "jump_view_right";
            "C-${h}" = "jump_view_left";
            "C-${j}" = "jump_view_down";
            "C-${k}" = "jump_view_up";
            "C-${l}" = "jump_view_right";
            "${L}" = "swap_view_right";
            "${K}" = "swap_view_up";
            "${H}" = "swap_view_left";
            "${J}" = "swap_view_down";
            "${w}" = {
              "s" = "hsplit_new";
              "v" = "vsplit_new";
              "C-s" = "hsplit_new";
              "C-v" = "vsplit_new";
            };
          };
          "C-${o}" = "jump_backward";
          "space" = {
            "n" = "jumplist_picker";
            # "w" = {
            #   "${h}" = "jump_view_left";
            #   "${j}" = "jump_view_down";
            #   "${k}" = "jump_view_up";
            #   "${l}" = "jump_view_right";
            #   "C-${h}" = "jump_view_left";
            #   "C-${j}" = "jump_view_down";
            #   "C-${k}" = "jump_view_up";
            #   "C-${l}" = "jump_view_right";
            #   "${H}" = "swap_view_left";
            #   "${j}" = "swap_view_down";
            #   "${k}" = "swap_view_up";
            #   "${L}" = "swap_view_right";
            #   "k" = {
            #     "s" = "hsplit_new";
            #     "v" = "vsplit_new";
            #     "C-s" = "hsplit_new";
            #     "C-v" = "vsplit_new";
            #   };
            # };
            "${y}" = "yank_to_clipboard";
            "${Y}" = "yank_main_selection_to_clipboard";
            "${h}" = "select_references_to_symbol_under_cursor";
            "p" = "replace_selections_with_clipboard";
          };
          "z" = {
            "${k}" = "scroll_up";
            "${j}" = "scroll_down";
            # "C-b" = "page_up";
            # "C-f" = "page_down";
            # "C-u" = "page_cursor_half_up";
            # "C-d" = "page_cursor_half_down";
            "${n}" = "search_next";
            "${N}" = "search_prev";
          };
          "Z" = {
            "${k}" = "scroll_up";
            "${j}" = "scroll_down";
            # "C-b" = "page_up";
            # "C-f" = "page_down";
            # "C-u" = "page_cursor_half_up";
            # "C-d" = "page_cursor_half_down";
            "${n}" = "search_next";
            "${N}" = "search_prev";
          };
        };
        select = {
          "${y}" = "yank";
          "${h}" = "extend_char_left";
          "${j}" = "extend_visual_line_down";
          "${k}" = "extend_visual_line_up";
          "${l}" = "extend_char_right";
          "${e}" = "extend_next_word_end";
          "${E}" = "extend_next_long_word_end";
          "A-${e}" = "extend_parent_node_end";
          "${n}" = "extend_search_next";
          "${N}" = "extend_search_prev";
          "g" = {
            "${k}" = "extend_line_up";
            "${j}" = "extend_line_down";
            "${h}" = "goto_line_start";
            "${l}" = "goto_line_end";
          };
          "space" = {
            "${y}" = "yank_to_clipboard";
            "${Y}" = "yank_main_selection_to_clipboard";
          };
        };
        insert = {
          # "C-u" = "kill_to_line_start";
          "C-${k}" = "kill_to_line_end";
          "C-${h}" = "delete_char_backward";
          # "C-${d}" = "delete_char_forward";
          "C-${j}" = "insert_newline";
        };
      };
    };
    # https://docs.helix-editor.com/languages.html
    languages = with config.commands; {
      language-server = {
        bash-language-server = {
          command = bash-language-server;
          args = ["start"];
        };

        clangd = {
          command = clangd;
          clangd.fallbackFlags = ["-std=c++2b"];
        };

        nil = {
          command = nil;
          config.nil.formatting.command = [alejandra "-q"];
        };

        vscode-css-language-server = {
          command = css-languageserver;
          args = ["--stdio"];
        };

        typescript-language-server = {
          command = typescript-language-server;
          args = ["--stdio" "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"];
        };
      };

      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = shfmt;
            args = ["-i" "2" "-"];
          };
        }
        {
          name = "clojure";
          injection-regex = "(clojure|clj|edn|boot|yuck)";
          file-types = ["clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck"];
        }
        {
          name = "nix";
          language-servers = [nixd];
        }
        {
          name = "rust";
          auto-format = false;
        }
      ];
    };
  };
}
