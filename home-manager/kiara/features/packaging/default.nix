{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./xwayland-satellite.nix
  ];
  
  home.packages =
    [
      pkgs.wineWowPackages.waylandFull
    ]
    ++ lib.attrValues {
      inherit
        (pkgs)
        mono
        xwayland
        xwayland-run
        ## nix
        
        any-nix-shell
        cachix
        ;
    };

  programs = {
    nix-index = {
      enable = true;
      symlinkToCacheHome = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      # enableNushellIntegration = true;
    };

    nix-index-database.comma.enable = true;
  };
}
