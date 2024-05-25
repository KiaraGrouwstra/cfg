{
  lib,
  pkgs,
  ...
}: {
  fonts.packages = lib.attrValues {
    inherit
      (pkgs)
      powerline-fonts
      twemoji-color-font
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      ;
  };
}
