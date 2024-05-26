{
  lib,
  pkgs,
  ...
}: {
  fonts.packages = lib.attrValues {
    inherit
      (pkgs)
      powerline-fonts
      twitter-color-emoji
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      hachimarupop
      ;
  };
}
