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

      ## language-specific
      nodePackages.markdownlint-cli
      texlive.combined.scheme-full
      gcc
      poetry
      yarn
      idris2
      hvm
      nixpkgs-fmt
      nixd
      haskellPackages.haskell-language-server
      ansible-language-server
      nodePackages.vim-language-server
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
      sqlite
      (python3.withPackages(ps : with ps; [
        pandas
        ipython
        ipython-sql
      ]))
      gettext
      nodejs-slim
      nodePackages.npm

      ## arduino
      arduino-cli
      arduino
      arduinoOTA

      ## terraform
      unfree.terraform
      terraform-providers.kubernetes
      terraform-providers.helm

      ## kubernetes
      kubectl
      minikube
      kubernetes-helm
      helm-dashboard
      openlens
      # k8sgpt
      argocd
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

  };
}
