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
  };
}
