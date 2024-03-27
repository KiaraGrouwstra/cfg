{
  pkgs,
  lib,
  config,
  ...
}:
with (import ./commands/pkgs.nix {inherit pkgs;}); {
  home.packages = let
    # redundant with mime associations / `programs.pistol` / `dmenu run`?
    commandDesktop = name: command: mimeTypes: (pkgs.makeDesktopItem {
      inherit name mimeTypes;
      desktopName = name;
      genericName = name;
      exec = "${terminal} ${command}";
      icon = "utilities-terminal";
      categories = ["Office" "Viewer"]; # https://askubuntu.com/a/674411/332744
    });
  in [
    # TODO: populate as per lesspipe
    # https://github.com/wofr06/lesspipe?tab=readme-ov-file#41-supported-compression-methods-and-archive-formats
    (commandDesktop "less" less [
      "text/plain"
      "text/html"
      "text/markdown" # mdcat / pandoc
      "application/json" # jq
      "application/vnd.smart.notebook" # pandoc
      "application/pdf" # poppler_utils
    ])

    (commandDesktop "xdg-open" xdg-open ["application/x-desktop"])

    (commandDesktop "glow" "${glow} -p" ["text/markdown"])

    (commandDesktop "lynx" lynx [
      "x-scheme-handler/https"
      "x-scheme-handler/http"
      "text/html"
    ])

    (commandDesktop "visidata" visidata [
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
      "application/vnd.ms-excel"
      "application/vnd.ms-excel.sheet.macroEnabled.12"
      "application/vnd.ms-excel.template.macroEnabled.12"
      "application/vnd.ms-excel.addin.macroEnabled.12"
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
      "text/csv"
    ])

    (commandDesktop "tar.gz" "tar.gz.sh" [
      "application/x-gzip"
      "application/x-tar"
    ])

    (commandDesktop "rar" "rar.sh" [
      "application/vnd.rar"
      "application/x-rar"
      "application/x-rar-compressed"
    ])

    (commandDesktop "zip" "zip.sh"
      ["application/x-zip"])

    (commandDesktop "webtorrent" "${webtorrent} download"
      ["x-scheme-handler/magnet"])

    # fallback option delegating MIME handling to pistol
    (
      commandDesktop "pistol" pistol
      # grab associations from programs.pistol
      (lib.lists.map (x: x.mime) config.programs.pistol.associations)
    )
  ];
}
