{
  lib,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/applications/wine"
    "Desktop"
    ".config/antimicrox"
  ];
  home.persistence."/persist/home/kiara".files = [
    ".local/share/applications/wine-extension-chm.desktop"
    ".local/share/applications/wine-extension-gif.desktop"
    ".local/share/applications/wine-extension-hlp.desktop"
    ".local/share/applications/wine-extension-htm.desktop"
    ".local/share/applications/wine-extension-ini.desktop"
    ".local/share/applications/wine-extension-jfif.desktop"
    ".local/share/applications/wine-extension-jpe.desktop"
    ".local/share/applications/wine-extension-msp.desktop"
    ".local/share/applications/wine-extension-pdf.desktop"
    ".local/share/applications/wine-extension-png.desktop"
    ".local/share/applications/wine-extension-rtf.desktop"
    ".local/share/applications/wine-extension-txt.desktop"
    ".local/share/applications/wine-extension-url.desktop"
    ".local/share/applications/wine-extension-vbs.desktop"
    ".local/share/applications/wine-extension-wri.desktop"
    ".local/share/applications/wine-extension-xml.desktop"
  ];
  home.packages = lib.attrValues {
    inherit
      (pkgs)
      antimicrox
    ;
  };
}
