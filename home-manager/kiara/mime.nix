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
    "inode/directory" = [ "org.gnome.Nautilus.desktop" "lapce.desktop" "codium.desktop" "less.desktop" ]; # gets hijacked: https://github.com/microsoft/vscode/issues/41037#issuecomment-369339898
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "text/calendar" = [ "org.gnome.Calendar.desktop" ];
    "application/pdf" = [ "org.gnome.Evince.desktop" "less.desktop" ];
    "application/x-code-workspace" = [ "lapce.desktop" "codium.desktop" ];
    "text/plain" = [ "lapce.desktop" "codium.desktop" "less.desktop" ];
    "text/markdown" = [ "glow.desktop" "codium.desktop" "less.desktop" ];
    "application/epub+zip" = [ "calibre-ebook-viewer.desktop" "calibre-ebook-edit.desktop" ];
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
    "writer"
    "less"
  ]; }) [
    "vnd.openxmlformats-officedocument.wordprocessingml.document"
    "vnd.openxmlformats-officedocument.wordprocessingml.template"
    "msword"
    "vnd.ms-word.document.macroEnabled.12"
    "vnd.ms-word.template.macroEnabled.12"
  ]) // (appsForTypes (type: { "application/vnd.${type}" = [
    "calc"
    "less"
  ]; }) [
    "openxmlformats-officedocument.spreadsheetml.sheet"
    "openxmlformats-officedocument.spreadsheetml.template"
    "ms-excel"
    "ms-excel.sheet.macroEnabled.12"
    "ms-excel.template.macroEnabled.12"
    "ms-excel.addin.macroEnabled.12"
    "ms-excel.sheet.binary.macroEnabled.12"
    "text/csv"
  ]) // (appsForTypes (type: { "application/vnd.${type}" = [
    "impress"
    "less"
  ]; }) [
    "openxmlformats-officedocument.presentationml.presentation"
    "openxmlformats-officedocument.presentationml.template"
    "openxmlformats-officedocument.presentationml.slideshow"
    "ms-powerpoint"
    "ms-powerpoint.addin.macroEnabled.12"
    "ms-powerpoint.presentation.macroEnabled.12"
    "ms-powerpoint.template.macroEnabled.12"
    "ms-powerpoint.slideshow.macroEnabled.12"
  ]) // (appsForTypes (type: { "x-scheme-handler/${type}" = [
    "firefox"
  ]; }) [
    "https"
    "http"
  ]);

}
