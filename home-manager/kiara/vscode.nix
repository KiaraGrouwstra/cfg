{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nodePackages.vscode-json-languageserver
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    # porting installed extensions: `codium --list-extensions | awk '{print tolower($0)}'`
    # finding new extensions: https://marketplace.visualstudio.com/vscode
    extensions = with (import ./vscode-extensions) {inherit pkgs lib;}; [
      # convenience
      mkhl.direnv
      mikestead.dotenv
      arrterian.nix-env-selector
      asvetliakov.vscode-neovim
      kahole.magit
      foam.foam-vscode
      editorconfig.editorconfig

      # styling
      pkief.material-icon-theme
      (pkgs.catppuccin-vsc.override {
        accent = "mauve";
        boldKeywords = true;
        italicComments = true;
        italicKeywords = true;
        extraBordersEnabled = false;
        workbenchMode = "default";
        bracketMode = "rainbow";
        colorOverrides = {};
        customUIColors = {};
      })
    ];
    userSettings = let
      # "b" -> { a = 1; } -> { b_a = 1; }
      inNamespace = prefix: lib.mapKeys (k: "${prefix}.${k}");
    in
      (inNamespace "nix" {
        enableLanguageServer = true;
        serverPath = "nixd";
        serverSettings = {
          nil = {formatting = {command = ["nixpkgs-fmt"];};};
        };
      })
      // (inNamespace "git" {
        confirmSync = false;
        autofetch = true;
        suggestSmartCommit = false;
        ignoreRebaseWarning = true;
      })
      // (inNamespace "editor" {
        "minimap.enabled" = false;
        smoothScrolling = true;
        # we try to make semantic highlighting look good
        "semanticHighlighting.enabled" = true;
      })
      // (inNamespace "workbench" {
        iconTheme = "material-icon-theme";
        "list.smoothScrolling" = true;
      })
      // (inNamespace "explorer" {
        "openEditors.visible" = 1;
        confirmDelete = false;
        confirmDragAndDrop = false;
      })
      // (inNamespace "terminal" {
        "integrated.smoothScrolling" = true;
        "integrated.enableMultiLinePasteWarning" = false;
        # prevent VSCode from modifying the terminal colors
        "integrated.minimumContrastRatio" = 1;
      })
      // {
        security.workspace.trust.untrustedFiles = "open";
        "redhat.telemetry.enabled" = false;
        diffignoreTrimWhitespace = false;
        # make the window's titlebar use the workbench colors
        "window.titleBarStyle" = "custom";
        # applicable if you use Go; this is an opt-in flag!
        gopls = {ui.semanticTokens = true;};
        "haskell.formattingProvider" = "fourmolu";
        # When opening a file; `tabSize` and `insertSpaces` will be detected based on the file contents.
        detectIndentation = false;
        "extensions.experimental.affinity" = {"asvetliakov.vscode-neovim" = 1;};
        "telemetry.telemetryLevel" = "off";
        "emeraldwalk.runonsave" = {
          commands = [
            {
              match = ".nomad.hcl";
              cmd = "nomad fmt \${file}";
            }
          ];
        };
      };
    keybindings = [
      {
        key = "ctrl+k ctrl+alt+s";
        command = "git.stageSelectedRanges";
        when = "!operationInProgress";
      }
      {
        key = "ctrl+k ctrl+n";
        command = "git.unstageSelectedRanges";
        when = "!operationInProgress";
      }
      {
        key = "ctrl+tab";
        command = "workbench.action.nextEditor";
        when = "!activeEditorGroupEmpty";
      }
      {
        key = "ctrl+shift+tab";
        command = "workbench.action.previousEditor";
        when = "!activeEditorGroupEmpty";
      }
      {
        key = "alt+a";
        command = "workbench.action.toggleMaximizedPanel";
      }
      {
        key = "Alt+Shift+B";
        command = "workbench.action.tasks.test";
      }
      {
        key = "ctrl+f";
        command = "-editor.action.pageDownHover";
        when = "editorHoverFocused";
      }
      {
        key = "ctrl+b";
        command = "-editor.action.pageUpHover";
        when = "editorHoverFocused";
      }
      {
        key = "capslock";
        command = "vscode-neovim.escape";
        when = "editorTextFocus && neovim.init && neovim.mode != 'normal' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+/";
        command = "-vscode-neovim.send";
        when = "editorTextFocus && neovim.ctrlKeysNormal./ && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "tab";
        command = "-vscode-neovim.send";
        when = "neovim.init && neovim.recording || editorTextFocus && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "shift+tab";
        command = "-vscode-neovim.send";
        when = "neovim.init && neovim.recording || editorTextFocus && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+w";
        command = "-vscode-neovim.send";
        when = "editorTextFocus && neovim.ctrlKeysNormal.w && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+w";
        command = "-vscode-neovim.send";
        when = "editorTextFocus && neovim.ctrlKeysInsert.w && neovim.init && neovim.mode == 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+f";
        command = "-vscode-neovim.ctrl-f";
        when = "editorTextFocus && neovim.ctrlKeysNormal.f && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+f";
        command = "-vscode-neovim.send";
        when = "editorTextFocus && neovim.ctrlKeysInsert.f && neovim.init && neovim.mode == 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+w";
        command = "-vscode-neovim.send-cmdline";
        when = "neovim.init && neovim.mode == 'cmdline'";
      }
      {
        key = "ctrl+w q";
        command = "-workbench.action.closeActiveEditor";
        when = "!editorTextFocus && !filesExplorerFocus && !searchViewletFocus && !terminalFocus";
      }
      {
        key = "ctrl+w ctrl+w";
        command = "-workbench.action.focusNextGroup";
        when = "!editorTextFocus && !filesExplorerFocus && !inSearchEditor && !replaceInputBoxFocus && !searchViewletFocus && !terminalFocus";
      }
      {
        key = "ctrl+w up";
        command = "-workbench.action.navigateUp";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w k";
        command = "-workbench.action.navigateUp";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w down";
        command = "-workbench.action.navigateDown";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w j";
        command = "-workbench.action.navigateDown";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w left";
        command = "-workbench.action.navigateLeft";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w h";
        command = "-workbench.action.navigateLeft";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w right";
        command = "-workbench.action.navigateRight";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w l";
        command = "-workbench.action.navigateRight";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w =";
        command = "-workbench.action.evenEditorWidths";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w s";
        command = "-workbench.action.splitEditorDown";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+w v";
        command = "-workbench.action.splitEditorRight";
        when = "!editorTextFocus && !terminalFocus";
      }
      {
        key = "ctrl+b";
        command = "-vscode-neovim.ctrl-b";
        when = "editorTextFocus && neovim.ctrlKeysNormal.b && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
      {
        key = "ctrl+b";
        command = "-vscode-neovim.send";
        when = "editorTextFocus && neovim.ctrlKeysInsert.b && neovim.init && neovim.mode == 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
      }
    ];
  };
}
