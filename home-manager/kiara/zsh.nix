{
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    zplug = {
      enable = true;
      plugins = [
        {
          name = "babarot/enhancd";
          tags = ["use:init.sh"];
        }
      ];
    };
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "git"
        "thefuck" # hit Esc twice after a failed command to get suggestions
        "bgnotify"
      ];
    };
    sessionVariables = {
      GTK_THEME = "Catppuccin-Frappe-Compact-Maroon-Dark";
      EDITOR = "nvim";
      VISUAL = "nvim";
      BROWSER = "firefox";
    };
    shellAliases = {
      docker-compose = "podman-compose";
      ls = "eza --icons";
      jq = "jaq";
      f = "fuck";  # in case zsh plugin's #1 suggestion won't do
      # ssh = "kitten ssh";  # for kitty
    };
    initExtra = lib.readFile ./zsh.zsh;
  };
}
