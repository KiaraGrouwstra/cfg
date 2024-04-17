{lib, ...}: {
  home.persistence."/persist/home/kiara" = {
    directories = [
      ".zplug"
    ];
    files = [
      ".zsh_history"
    ];
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
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
    shellAliases = {
      docker-compose = "podman-compose";
      ls = "eza --icons";
      jq = "jaq";
      f = "fuck"; # in case zsh plugin's #1 suggestion won't do
      # ssh = "kitten ssh";  # for kitty
    };
    initExtra = lib.readFile ./zsh.zsh;
  };
}
