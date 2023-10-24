{ config, pkgs, ... }:

{
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" "lapce.desktop" "codium.desktop" ];
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "text/calendar" = [ "org.gnome.Calendar.desktop" ];
    "application/pdf" = [ "org.gnome.Evince.desktop" ];
    "application/x-code-workspace" = [ "lapce.desktop" "codium.desktop" ];
    "text/plain" = [ "lapce.desktop" "codium.desktop" ];
    "text/markdown" = [ "glow.desktop" "codium.desktop" ];
    "application/epub+zip" = [ "calibre-ebook-viewer.desktop" "calibre-ebook-edit.desktop" ];
  } // (builtins.listToAttrs (map (type: { "image/${type}" = [ "swayimg.desktop" "org.gnome.eog.desktop" "gimp.desktop" ]; }) [
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
  ])) // (builtins.listToAttrs (map (type: { "application/${type}" = [ "writer.desktop" ]; }) [
    "vnd.openxmlformats-officedocument.wordprocessingml.document"
    "vnd.openxmlformats-officedocument.wordprocessingml.template"
    "msword"
    "vnd.ms-word.document.macroEnabled.12"
    "vnd.ms-word.template.macroEnabled.12"
  ])) // (builtins.listToAttrs (map (type: { "application/vnd.${type}" = [ "calc.desktop" ]; }) [
    "openxmlformats-officedocument.spreadsheetml.sheet"
    "openxmlformats-officedocument.spreadsheetml.template"
    "ms-excel"
    "ms-excel.sheet.macroEnabled.12"
    "ms-excel.template.macroEnabled.12"
    "ms-excel.addin.macroEnabled.12"
    "ms-excel.sheet.binary.macroEnabled.12"
  ])) // (builtins.listToAttrs (map (type: { "application/vnd.${type}" = [ "impress.desktop" ]; }) [
    "openxmlformats-officedocument.presentationml.presentation"
    "openxmlformats-officedocument.presentationml.template"
    "openxmlformats-officedocument.presentationml.slideshow"
    "ms-powerpoint"
    "ms-powerpoint.addin.macroEnabled.12"
    "ms-powerpoint.presentation.macroEnabled.12"
    "ms-powerpoint.template.macroEnabled.12"
    "ms-powerpoint.slideshow.macroEnabled.12"
  ]));
}
