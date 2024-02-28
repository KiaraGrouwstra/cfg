_: {
  # seems still used in DMs
  services.xserver = {
    enable = true;

    displayManager = {
      # session = [ ];
      autoLogin = {
        enable = true;
        user = "kiara";
      };
    };

    # keymap in X11
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
  };
}
