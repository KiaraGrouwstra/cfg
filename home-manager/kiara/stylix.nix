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
  stylix = {
    cursor = {
      # https://github.com/catppuccin/cursors#previews
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "Catppuccin-Mocha-Dark-Cursors";
      size = 48;
    };

    fonts = with config.fontProfiles; {
      inherit monospace emoji;
      serif = regular;
      sansSerif = regular;
      sizes = {
        applications = 14;
        desktop = 14;
        popups = 14;
        terminal = 16;
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
    platformTheme = "qtct";
    style.name = lib.mkForce "kvantum";
  };

  gtk = {
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
      # https://github.com/catppuccin/gtk
      name = "Catppuccin-Mocha-Compact-Maroon-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        size = "compact";
        accents = ["maroon"];
        tweaks = ["rimless" "black"];
      };
    };
  };

  # https://search.nixos.org/packages?query=kde+theme
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-qt5ct
    (catppuccin-kvantum.override {
      # https://github.com/catppuccin/kde#previews
      variant = "Mocha";
      # https://github.com/catppuccin/catppuccin#-palette
      accent = "Maroon";
    })
  ];
}
