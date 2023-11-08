{ ... }:

{

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      catppuccin-theme
      nix-mode
      magit
      tramp
      notmuch
      offlineimap
      org
      direnv
    ];
  };

  programs.offlineimap.enable = true;

}
