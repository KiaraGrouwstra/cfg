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
      vscodium
      lapce
      vim
      amp
      helix
      featherpad
      libsForQt5.kate
      nota
      gnome-text-editor

      ## command-line document viewers / editors
      unixtools.column
      poppler_utils
      pdf2odt
      xsv
      csvkit
      dex

      ## markdown
      glow
      ghostwriter
      apostrophe
      okular
      mdcat

      ## document viewers / editors
      evince
      calibre
      libreoffice-fresh
    ];

    programs.lesspipe.enable = true;

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        pywal-nvim
        nvchad
        nvchad-ui
        chadtree
        nvim-treesitter.withAllGrammars
      ];
    };

    # used by enhancd
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

  };
}
