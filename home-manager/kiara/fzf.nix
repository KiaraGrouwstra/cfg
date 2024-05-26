{config, ...}: let
  inherit (config.commands) pistol fzf wl-copy;
in {
  programs.fzf = {
    enable = true;
    # https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
    enableZshIntegration = true;
    # enableNushellIntegration = true;
    # colors = {
    #   bg = "#000000";
    #   "bg+" = "#FF00FF";
    #   fg = "#FF00FF";
    #   "fg+" = "#000000";
    # };
    defaultOptions = [
      "--sort"
      "--height 100%"
      "--border"
    ];
    # hotkeys: https://github.com/junegunn/fzf#key-bindings-for-command-line
    # CTRL-T: take file
    fileWidgetOptions = [
      "--preview '${pistol} {}'"
    ];
    # CTRL-R: redo
    historyWidgetOptions = [
      "--sort"
      "--exact"
      "--preview 'echo {}'"
      "--preview-window up:3:hidden:wrap"
      "--bind 'ctrl-/:toggle-preview'"
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | ${wl-copy})+abort'"
      "--color header:italic"
      "--header 'Press CTRL-Y to copy command into clipboard'"
    ];
    # ALT-C: cd
    changeDirWidgetOptions = [
      "--preview '${pistol} {}'"
    ];
  };

  home.sessionVariables.ENHANCD_FILTER = "${fzf} --preview '${pistol} {}'";
}
