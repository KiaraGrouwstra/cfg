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
      keys = let
        inherit (config.keyboard.vi) d f h j k l e n y o w E O N J K L H Y;
      in {
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
          "s" = "select_line_below";
          "S" = "select_line_above";
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
            "${k}" = "move_line_up";
            "${j}" = "move_line_down";
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
          "${y}" = "yank_to_clipboard";
          "p" = "paste_clipboard_after";
          "P" = "paste_clipboard_before";
          "R" = "replace_selections_with_clipboard";
          "c" = "change_selection_noyank";
          "d" = ["yank_to_clipboard" "delete_selection_noyank"];
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
            "p" = "paste_clipboard_after";
            "P" = "paste_clipboard_before";
            "R" = "replace_selections_with_clipboard";
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
          "${y}" = "yank_to_clipboard";
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
    languages = let
      inherit (config.commands) nil nixd alejandra shfmt typos-lsp;
    in {
      language-server = {
        typos.command = typos-lsp;
        
        nil.command = nil;

        nixd = {
          command = nixd;
          config = {
            nixpkgs.expr = "import <nixpkgs> { }";
            options = {
              nixos.expr = "(builtins.getFlake \"/etc/nixos\").nixosConfigurations.default.options";
              home-manager.expr = "(builtins.getFlake \"/etc/nixos\").homeConfigurations.default.options";
            };
          };
        };
      };

      # https://github.com/helix-editor/helix/blob/master/book/src/languages.md#language-configuration
      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = shfmt;
            args = ["-i" "2" "-"];
          };
          language-servers = [ "bash-language-server" "typos" ];
        }
        {
          name = "clojure";
          injection-regex = "(clojure|clj|edn|boot|yuck)";
          file-types = ["clj" "cljs" "cljc" "clje" "cljr" "cljx" "edn" "boot" "yuck"];
        }
        {
          name = "nix";
          roots = ["flake.nix" "flake.lock"];
          language-servers = ["nixd" "typos"];
          auto-format = false;
          formatter = {
            command = alejandra;
            args = ["-q"];
          };
        }
        {
          name = "python";
          file-types = ["py"];
          roots = ["pyproject.toml" "setup.py" "poetry.lock" "pyrightconfig.json"];
          language-servers = ["pylsp" "typos"];
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "rust";
          auto-format = false;
        }
      ];
    };
  };
}
