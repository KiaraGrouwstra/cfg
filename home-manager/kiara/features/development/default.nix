{ lib, config, pkgs, unfree, ... }:

with lib;

let cfg = config.toggles.development;
in {
  options.toggles.development.enable = mkEnableOption "development";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ## development
      direnv
      gnumake
      woodpecker-cli
      asdf-vm
      bruno

      ## version control
      git
      git-crypt # sudo ln -s $(which git-crypt) /usr/bin/git-crypt
      gitui
      git-interactive-rebase-tool
      git-cola
      gitg

      ## language-specific
      nodePackages.markdownlint-cli
      texlive.combined.scheme-full
      gcc
      poetry
      jdk
      yarn
      idris2
      hvm
      nixpkgs-fmt
      nixd
      nil
      cargo
      haskellPackages.haskell-language-server
      ansible-language-server
      nodePackages.vim-language-server
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
      kotlin-language-server
      sqlite
      (python3.withPackages(ps : with ps; [
        pandas
        ipython
        ipython-sql
      ]))
      gettext
      nodejs-slim
      nodePackages.npm
      unfree.neo4j-desktop

      ## arduino
      arduino-cli
      arduino
      arduinoOTA
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      # https://github.com/topics/gh-extension
      extensions = with pkgs; [
        gh-dash
        gh-markdown-preview
      ];
      settings = {
        version = 1;
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

  };

  # nomad-driver-nix
  options.nix-driver-nomad.enable = mkIf cfg.enable true;

}
