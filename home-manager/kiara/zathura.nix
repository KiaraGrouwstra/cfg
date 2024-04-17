_: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/zathura"
  ];
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      selection-clipboard = "clipboard";
    };
  };
}
