{ lib, ... }:

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
      GTK_THEME = "Catppuccin-Frappe-Compact-Maroon-Dark";
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
    shellAliases = {
      docker-compose = "podman-compose";
    };
    initExtra = (lib.readFile ./zsh.zsh);
  };
}
