{ ... }:

let
  addDesktop = x: "${x}.desktop";
  appsForTypes = pattern: types: (
    builtins.foldl'
    (x: y: x // y)
    {}
    (
      map
      (x: builtins.mapAttrs (_: map addDesktop) (pattern x))
      types
    )
  );
in

{

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "ranger.desktop" "org.gnome.Nautilus.desktop" "codium.desktop" "lapce.desktop" "less.desktop" ]; # gets hijacked: https://github.com/microsoft/vscode/issues/41037#issuecomment-369339898
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "text/calendar" = [ "org.gnome.Calendar.desktop" ];
    "application/pdf" = [ "less.desktop" "org.gnome.Evince.desktop" ];
    "application/x-code-workspace" = [ "codium.desktop" "lapce.desktop" ];
    "inode/x-empty" = [ "codium.desktop" "lapce.desktop" "kate.desktop" ];
    "text/plain" = [ "less.desktop" "codium.desktop" "lapce.desktop" ];
    "text/markdown" = [ "less.desktop" "glow.desktop" "codium.desktop" ];
    "application/epub+zip" = [ "less.desktop" "calibre-ebook-viewer.desktop" "calibre-ebook-edit.desktop" ];
  } // (appsForTypes (type: { "application/vnd.${type}" = [
    "swayimg"
    "org.gnome.eog"
    "gimp"
    "less"
  ]; }) [
    "jpeg"
    "bmp"
    "gif"
    "jpg"
    "pjpeg"
    "png"
    "tiff"
    "webp"
    "x-bmp"
    "x-gray"
    "x-icb"
    "x-ico"
    "x-png"
    "x-portable-anymap"
    "x-portable-bitmap"
    "x-portable-graymap"
    "x-portable-pixmap"
    "x-xbitmap"
    "x-xpixmap"
    "x-pcx"
    "svg+xml"
    "svg+xml-compressed"
    "vnd.wap.wbmp"
    "x-icns"
  ]) // (appsForTypes (type: { "application/${type}" = [
    "less"
    "writer"
  ]; }) [
    "vnd.openxmlformats-officedocument.wordprocessingml.document"
    "vnd.openxmlformats-officedocument.wordprocessingml.template"
    "msword"
    "vnd.ms-word.document.macroEnabled.12"
    "vnd.ms-word.template.macroEnabled.12"
  ]) // (appsForTypes (type: { "application/vnd.${type}" = [
    "visidata"
    "less"
    "calc"
  ]; }) [
    "openxmlformats-officedocument.spreadsheetml.sheet"
    "openxmlformats-officedocument.spreadsheetml.template"
    "ms-excel"
    "ms-excel.sheet.macroEnabled.12"
    "ms-excel.template.macroEnabled.12"
    "ms-excel.addin.macroEnabled.12"
    "ms-excel.sheet.binary.macroEnabled.12"
  ]) // (appsForTypes (type: { "${type}" = [
    "visidata"
    "calc"
    "less"
  ]; }) [
    "text/csv"
  ]) // (appsForTypes (type: { "application/vnd.${type}" = [
    "less"
    "impress"
  ]; }) [
    "openxmlformats-officedocument.presentationml.presentation"
    "openxmlformats-officedocument.presentationml.template"
    "openxmlformats-officedocument.presentationml.slideshow"
    "ms-powerpoint"
    "ms-powerpoint.addin.macroEnabled.12"
    "ms-powerpoint.presentation.macroEnabled.12"
    "ms-powerpoint.template.macroEnabled.12"
    "ms-powerpoint.slideshow.macroEnabled.12"
  ]) // (appsForTypes (type: { "application/vnd.${type}" = [
    "less"
  ]; }) [
    "smart.notebook"
  ]) // (appsForTypes (type: { "x-scheme-handler/${type}" = [
    "firefox"
  ]; }) [
    "https"
    "http"
  ]) // (appsForTypes (type: { "application/x-${type}" = [
    "tar.gz"
  ]; }) [
    "gzip"
    "tar"
  ]) // (appsForTypes (type: { "application/x-${type}" = [
    "zip"
  ]; }) [
    "zip"
  ]);

}
