{pkgs, ...}: {
  home.packages = with pkgs; [
    ## nix
    any-nix-shell
    cachix
  ];

  programs = {
    nix-index = {
      enable = true;
      symlinkToCacheHome = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

    nix-index-database.comma.enable = true;
  };
}
