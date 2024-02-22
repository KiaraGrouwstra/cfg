{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ## nix
    any-nix-shell
    nix-direnv

    ## packaging
    appimage-run
  ];

  programs.nix-index = {
    enable = true;
    symlinkToCacheHome = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs.nix-index-database.comma.enable = true;

}
