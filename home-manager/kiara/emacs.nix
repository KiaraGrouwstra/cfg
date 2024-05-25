{lib, ...}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      lib.attrValues {
        inherit
          (epkgs)
          wal-mode
          nix-mode
          magit
          tramp
          notmuch
          offlineimap
          org
          direnv
          doom
          ;
      };
  };

  programs.offlineimap.enable = true;
}
