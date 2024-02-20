{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ## development
    direnv
    treefmt

    ## version control
    git
    git-crypt # sudo ln -s $(which git-crypt) /usr/bin/git-crypt
    git-interactive-rebase-tool
    gitg

    ## language-specific
    nixpkgs-fmt
    nixd
    nil
    haskellPackages.haskell-language-server
    ansible-language-server
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    kotlin-language-server
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    mise = {
      enable = true;
      globalConfig = {
        tools = {
          # node = "lts";
          # python = [ "3.10" "3.11" ];
        };
      };
      settings = {
        verbose = false;
        experimental = true;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      # https://github.com/topics/gh-extension
      extensions = with pkgs; [gh-dash gh-markdown-preview];
      settings = {
        version = 1;
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
