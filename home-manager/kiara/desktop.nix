{
  pkgs,
  lib,
  config,
  ...
}:
with config.commands; {
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
    genericDesktop = name: attrs: (pkgs.makeDesktopItem ({
        inherit name;
        desktopName = name;
        genericName = name;
      }
      // attrs));
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

    # https://code.google.com/archive/p/theunarchiver/wikis/SupportedFormats.wiki
    (commandDesktop "unar" "unar.sh" [
      "application/x-zip"
      "application/x-gzip"
      "application/x-gzip-compressed"
      "application/gzip-compressed"
      "application/gzipped"
      "gzip/document"
      "application/gzip"
      "application/x-gunzip"
      "application/x-tar"
      "application/vnd.rar"
      "application/x-rar"
      "application/x-rar-compressed"
      "application/x-bzip2"
      "application/x-7z-compressed"
    ])

    (commandDesktop "webtorrent" "${webtorrent} download"
      ["x-scheme-handler/magnet"])

    # fallback option delegating MIME handling to pistol
    (
      commandDesktop "pistol" pistol
      # grab associations from programs.pistol
      (lib.lists.map (x: x.mime) config.programs.pistol.associations)
    )

    (genericDesktop "Shut down" {
      exec = "systemctl poweroff -i";
      icon = "system-shutdown";
    })

    (genericDesktop "Restart" {
      exec = "systemctl reboot";
      icon = "system-reboot";
    })

    (genericDesktop "Log out" {
      exec = "niri msg action quit";
      icon = "system-log-out";
    })

    (genericDesktop "Suspend" {
      exec = "systemctl suspend-then-hibernate";
      icon = "system-suspend";
    })

    (genericDesktop "Hibernate" {
      exec = "systemctl hibernate";
      icon = "system-hibernate";
    })

    (genericDesktop "Lock" {
      exec = "swaylock";
      icon = "system-lock-screen";
    })
  ];
}
