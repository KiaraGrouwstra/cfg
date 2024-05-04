{inputs, ...}: {
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
      layout = "us,workman-p";
      extraLayouts = {
        workman-p = {
          description = "https://workmanlayout.org/#introducing-the-workman-keyboard-layout";
          languages = ["eng"];
          symbolsFile = "${inputs.workman}/xorg/workman-p";
        };
      };
      variant = "";
      options = "caps:escape";
    };
  };
}
