{ lib, pkgs, ... }:

{

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    # codium --list-extensions | awk '{print tolower($0)}'
    # TODO: updating https://github.com/nix-community/nix4vscode/issues/13
    extensions = with (import ./vscode-extensions) { inherit pkgs lib; }; [

      # convenience
      mkhl.direnv
      mikestead.dotenv
      arrterian.nix-env-selector
      asvetliakov.vscode-neovim
      kahole.magit
      foam.foam-vscode

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

      # highlighting
      jnoortheen.nix-ide
      tamasfe.even-better-toml
      hashicorp.hcl
      hashicorp.terraform
      justusadam.language-haskell
      kokakiwi.vscode-just
      haskell.haskell
      meraymond.idris-vscode
      marp-team.marp-vscode
      rust-lang.rust
      vscode-org-mode.org-mode
      redhat.vscode-yaml

      # linting
      editorconfig.editorconfig
      davidanson.vscode-markdownlint
    ];
    # haskell = {
    #   enable = true;
    #   hie.enable = true;
    # };
    userSettings = {
      nix = {
        enableLanguageServer = true;
        serverPath = "nixd";
        serverSettings = {
          nil = {
            formatting = {
              command = [
                "nixpkgs-fmt"
              ];
            };
          };
        };
      };
      git = {
        confirmSync = false;
        autofetch = true;
        suggestSmartCommit = false;
        ignoreRebaseWarning = true;
      };
      editor = {
        minimap.enabled = false;
        smoothScrolling = true;
        # we try to make semantic highlighting look good
        semanticHighlighting.enabled = true;
      };
      security.workspace.trust.untrustedFiles = "open";
      workbench = {
        iconTheme = "material-icon-theme";
        list.smoothScrolling = true;
        # Catppuccin
        colorTheme = "Catppuccin Frappé";
      };
      explorer = {
        openEditors.visible = 1;
        confirmDelete = false;
        confirmDragAndDrop = false;
      };
      redhat.telemetry.enabled = false;
      diffignoreTrimWhitespace = false;
      terminal = {
        integrated.smoothScrolling = true;
        integrated.enableMultiLinePasteWarning = false;
        # prevent VSCode from modifying the terminal colors
        integrated.minimumContrastRatio = 1;
      };
      # make the window's titlebar use the workbench colors
      window.titleBarStyle = "custom";
      # applicable if you use Go; this is an opt-in flag!
      gopls = {
        ui.semanticTokens = true;
      };
      haskell.formattingProvider = "fourmolu";
      # When opening a file; `tabSize` and `insertSpaces` will be detected based on the file contents.
      detectIndentation = false;
      extensions.experimental.affinity = {
        asvetliakov.vscode-neovim = 1;
      };
      emeraldwalk.runonsave = {
        commands = [
          {
            match = "\\.nomad\\.hcl";
            cmd = "nomad fmt \${file}";
          }
        ];
      };
    };
    # keybindings = [];
  };

}
