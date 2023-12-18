{ pkgs, inputs, lib, ... }:

with (import ./commands.nix { pkgs = pkgs; inputs = inputs; });
{
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
        { name = "babarot/enhancd"; tags = [ "use:init.sh" ]; }
      ];
    };
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "${git}"
        "${thefuck}"
      ];
      theme = "agnoster";
    };
    sessionVariables = {
      GTK_THEME = "Catppuccin-Frappe-Compact-Maroon-Dark";
      EDITOR = "nvim"; # programs.firefox.package
      VISUAL = "${less}";
      BROWSER = "firefox"; # programs.firefox.package
    };
    shellAliases = {
      docker-compose = "podman-compose";
      cat = "${bat}";
      ls = "${eza}";
      vi = "nvim";
      vim = "nvim";
      ssh = "${kitten} ${ssh}";
      grep = "${rg}";
    };
    initExtra = (lib.readFile ./zsh.zsh);
  };
}
