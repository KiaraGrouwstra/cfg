{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    regular = {
      family = "knsw_HachiMaruPop";
      package = pkgs.hachimarupop;
    };
  };
}
