{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.text;
in {
  options.toggles.text.enable = mkEnableOption "text";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## text editors
      vscode  # https://github.com/NixOS/nixpkgs/issues/237978
      lapce
      vim
      amp
      helix
      hexyl
      featherpad
      libsForQt5.kate
      nota
      gnome-text-editor

      ## command-line document viewers / editors
      unixtools.column
      poppler_utils
      pdf2odt
      xsv
      # csvkit  # https://github.com/NixOS/nixpkgs/issues/281150
      dex

      ## markdown
      glow
      ghostwriter
      apostrophe
      okular
      mdcat
      typst

      ## document viewers / editors
      evince
      calibre
      libreoffice-fresh
    ];

    programs.lesspipe.enable = true;

    # used by enhancd
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

  };
}
