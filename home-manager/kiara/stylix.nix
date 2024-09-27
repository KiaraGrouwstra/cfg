{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  nix-colors-lib = inputs.nix-colors.lib.contrib {inherit pkgs;};
in {
  # If I can't dance to it, it's not my revolution. - Emma Goldman

  home.sessionVariables = {
    GTK_THEME = config.gtk.theme.name;
  };

  stylix = {
    enable = true;
    autoEnable = true;

    cursor = {
      # https://github.com/catppuccin/cursors#previews
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      size = 48;
    };

    fonts = let
      inherit (config.fontProfiles) regular monospace emoji;
    in {
      inherit monospace emoji;
      serif = regular;
      sansSerif = regular;
      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 14;
      };
    };

    opacity = {
      applications = 0.9;
      desktop = 0.9;
      popups = 0.9;
      terminal = 0.9;
    };

    polarity = "dark";

    # for gtk used by e.g. pkgs.gnome.nautilus
    base16Scheme = config.colorscheme.palette;

    image = nix-colors-lib.nixWallpaperFromScheme {
      scheme = config.colorscheme;
      width = 1366;
      height = 768;
      logoScale = 3.0;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
    # ls ~/.nix-profile/share/Kvantum/*/*.kvconfig
    General.theme = "Catppuccin-Mocha-Maroon";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = lib.mkForce "kvantum";
  };

  gtk = {
    enable = true;
    iconTheme = {
      # https://github.com/catppuccin/papirus-folders#previews
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "maroon";
      };
      name = "Papirus-Dark";
    };
    # used by e.g. pkgs.gitg
    theme = lib.mkForce {
      package = pkgs.materia-theme;
      name = "Materia-dark-compact";
    };
  };

  # https://search.nixos.org/packages?query=kde+theme
  home.packages = [
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.catppuccin-qt5ct
    (pkgs.catppuccin-kvantum.override {
      # https://github.com/catppuccin/kde#previews
      variant = "Mocha";
      # https://github.com/catppuccin/catppuccin#-palette
      accent = "Maroon";
    })
  ];
}
