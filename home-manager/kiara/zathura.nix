{
  config,
  lib,
  inputs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/zathura"
  ];
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      selection-clipboard = "clipboard";
    };
    extraConfig =
      if config.keyboard.active == "workman"
      then lib.readFile "${inputs.workman-vim}/zathurarc"
      else "";
  };
}
