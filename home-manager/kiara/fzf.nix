{
  lib,
  config,
  ...
}: let
  inherit (config.commands) pistol fzf wl-copy;
  # https://manpages.debian.org/unstable/fzf/fzf.1.en.html
  common = [
    "--reverse"
    "--preview 'echo {}'"
    "--preview-window up:3:hidden:wrap"
    "--bind 'ctrl-/:toggle-preview'"
    "--bind 'ctrl-y:execute-silent(echo -n {2..} | ${wl-copy})+abort'"
    "--bind=tab:down"
    "--bind=shift-tab:up"
    "--sort"
    "--height 100%"
    "--border"
    "--header 'Press CTRL-Y to copy to clipboard'"
    "--color header:italic"
  ];
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
    defaultOptions = common;
    # hotkeys: https://github.com/junegunn/fzf#key-bindings-for-command-line
    # CTRL-T: take file
    fileWidgetOptions = common ++ [
      "--preview '${pistol} {}'"
    ];
    # CTRL-R: redo
    historyWidgetOptions = common;
    # ALT-C: cd
    changeDirWidgetOptions = common ++ [
      "--preview '${pistol} {}'"
    ];
  };

  home.sessionVariables.ENHANCD_FILTER = "${fzf} ${lib.concatStringsSep " " common} --preview '${pistol} {}'";
}
