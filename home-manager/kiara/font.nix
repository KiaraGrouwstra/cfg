{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    regular = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    monospace = {
      # https://www.nerdfonts.com/font-downloads
      package = pkgs.nerdfonts.override {fonts = ["MartianMono" "FiraCode"];};
      name = "MartianMono Nerd Font";
    };
    # https://search.nixos.org/packages?query=emoji
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
