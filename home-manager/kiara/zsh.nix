{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "agnoster";
    };
    sessionVariables = {
      GTK_THEME = "palenight";
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
    shellAliases = {
      docker-compose = "podman-compose";
    };
    initExtra = (builtins.readFile ./zsh.zsh);
  };
}
