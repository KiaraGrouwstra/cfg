{...}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        wal-mode
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
