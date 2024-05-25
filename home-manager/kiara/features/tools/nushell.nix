_: {
  home.persistence."/persist/home/kiara" = {
    directories = [
      ".config/nushell"
    ];
  };
  programs.nushell = {
    enable = true;
  };
}
