{ pkgs, inputs, ... }:

with (import ./commands.nix { pkgs = pkgs; inputs = inputs; });
{

  home.packages = let
    commandDesktop = (name: command: mimeTypes:
      (pkgs.makeDesktopItem {
        name = name;
        desktopName = name;
        genericName = name;
        exec = "${terminal} ${command}";
        icon = "utilities-terminal";
        categories = [ "Office" "Viewer" ]; # https://askubuntu.com/a/674411/332744
        mimeTypes = mimeTypes;
      })
    );
  in
  [

    (commandDesktop "less" "${less}" [
      "text/plain"
      "text/html"
      "text/markdown" # mdcat / pandoc
      "application/json" # jq
      "application/vnd.smart.notebook" # pandoc
      "application/pdf" # poppler_utils
    ])

    (commandDesktop "glow" "${glow}" [
      "text/markdown"
    ])

    (commandDesktop "lynx" "${lynx}" [
      "x-scheme-handler/https"
      "x-scheme-handler/http"
      "text/html"
    ])

    (commandDesktop "visidata" "${visidata}" [
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
      "application/vnd.ms-excel"
      "application/vnd.ms-excel.sheet.macroEnabled.12"
      "application/vnd.ms-excel.template.macroEnabled.12"
      "application/vnd.ms-excel.addin.macroEnabled.12"
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
      "text/csv"
    ])

    (commandDesktop "tar.gz" ("" + ./dotfiles/.config/hypr/scripts/tar.gz.sh) [
      "application/x-gzip"
      "application/x-tar"
    ])

    (commandDesktop "zip" ("" + ./dotfiles/.config/hypr/scripts/zip.sh) [
      "application/x-zip"
    ])

    (commandDesktop "webtorrent" "${webtorrent} download" [
      "x-scheme-handler/magnet"
    ])

  ];

}
