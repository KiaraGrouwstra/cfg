{
  lib,
  pkgs,
  lime3ds,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/Steam"
    ".local/share/lutris"
    ".local/share/citra-emu"
    ".steam"
    "Desktop"
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
    ".local/share/applications/Smash MAGA! Trump Zombie Apocalypse.desktop"
    ".local/share/applications/Crypt of the NecroDancer.desktop"
    ".local/share/applications/Steam Linux Runtime 3.0 (sniper).desktop"
    ".local/share/applications/Battle for Wesnoth.desktop"
    ".local/share/applications/Resonite.desktop"
    ".local/share/applications/Crush Crush.desktop"
    ".local/share/applications/Proton Experimental.desktop"
    ".local/share/applications/Monster Hunter World.desktop"
  ];
  home.packages =
    [
      lime3ds.lime3ds
    ]
    ++ lib.attrValues {
      inherit
        (pkgs)
        lutris
        antimicrox
        retro-gtk
        retroarch
        # retroarchFull
        ;
    };
}
