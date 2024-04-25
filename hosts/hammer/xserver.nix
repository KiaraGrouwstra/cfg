_: {
  services.displayManager = {
    # session = [ ];
    autoLogin = {
      enable = true;
      user = "kiara";
    };
  };

  # seems still used in DMs
  services.xserver = {
    enable = true;

    # keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };
}
