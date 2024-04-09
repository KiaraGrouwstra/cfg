{
  lib,
  config,
  ...
}: {
  home.sessionVariables.COLORTERM = "truecolor";

  programs.helix = {
    enable = true;
    # https://docs.helix-editor.com/configuration.html
    settings = {
      theme = lib.mkForce "base16_transparent";
      editor = {
        auto-save = true;
        line-number = "relative";
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
      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        space.x = ":buffer-close";
        esc = ["collapse_selection" "keep_primary_selection"];
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
