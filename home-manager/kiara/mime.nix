{lib, config, ...}: let
  addDesktop = x: "${x}.desktop";
  # take from the respective mimetype files
  images = map (_: "image/${_}") [
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
    "*"
  ];
  urls = [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/unknown"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
  ];
  readable = [
    "application/vnd.comicbook-rar"
    "application/vnd.comicbook+zip"
    "application/x-cb7"
    "application/x-cbr"
    "application/x-cbt"
    "application/x-cbz"
    "application/x-ext-cb7"
    "application/x-ext-cbr"
    "application/x-ext-cbt"
    "application/x-ext-cbz"
    "application/x-ext-djv"
    "application/x-ext-djvu"
    "image/vnd.djvu+multipage"
    "application/x-bzdvi"
    "application/x-dvi"
    "application/x-ext-dvi"
    "application/x-gzdvi"
    "application/pdf"
    "application/x-bzpdf"
    "application/x-ext-pdf"
    "application/x-gzpdf"
    "application/x-xzpdf"
    "application/postscript"
    "application/x-bzpostscript"
    "application/x-gzpostscript"
    "application/x-ext-eps"
    "application/x-ext-ps"
    "image/x-bzeps"
    "image/x-eps"
    "image/x-gzeps"
    "image/tiff"
    "application/oxps"
    "application/vnd.ms-xpsdocument"
    "application/illustrator"
  ];
  documents = map (_: "application/${_}") [
    "vnd.oasis.opendocument.text"
    "vnd.openxmlformats-officedocument.wordprocessingml.document"
    "vnd.openxmlformats-officedocument.wordprocessingml.template"
    "msword"
    "vnd.ms-word.document.macroEnabled.12"
    "vnd.ms-word.template.macroEnabled.12"
  ];
  spreadsheets = map (_: "application/vnd.${_}") [
    "openxmlformats-officedocument.spreadsheetml.sheet"
    "openxmlformats-officedocument.spreadsheetml.template"
    "ms-excel"
    "ms-excel.sheet.macroEnabled.12"
    "ms-excel.template.macroEnabled.12"
    "ms-excel.addin.macroEnabled.12"
    "ms-excel.sheet.binary.macroEnabled.12"
  ];
  slides = map (_: "application/vnd.${_}") [
    "openxmlformats-officedocument.presentationml.presentation"
    "openxmlformats-officedocument.presentationml.template"
    "openxmlformats-officedocument.presentationml.slideshow"
    "ms-powerpoint"
    "ms-powerpoint.addin.macroEnabled.12"
    "ms-powerpoint.presentation.macroEnabled.12"
    "ms-powerpoint.template.macroEnabled.12"
    "ms-powerpoint.slideshow.macroEnabled.12"
  ];
  audio = [
    "application/ogg"
    "application/x-ogg"
    "application/mxf"
    "application/sdp"
    "application/smil"
    "application/x-smil"
    "application/streamingmedia"
    "application/x-streamingmedia"
    "application/vnd.rn-realmedia"
    "application/vnd.rn-realmedia-vbr"
    "audio/aac"
    "audio/x-aac"
    "audio/vnd.dolby.heaac.1"
    "audio/vnd.dolby.heaac.2"
    "audio/aiff"
    "audio/x-aiff"
    "audio/m4a"
    "audio/x-m4a"
    "application/x-extension-m4a"
    "audio/mp1"
    "audio/x-mp1"
    "audio/mp2"
    "audio/x-mp2"
    "audio/mp3"
    "audio/x-mp3"
    "audio/mpeg"
    "audio/mpeg2"
    "audio/mpeg3"
    "audio/mpegurl"
    "audio/x-mpegurl"
    "audio/mpg"
    "audio/x-mpg"
    "audio/rn-mpeg"
    "audio/musepack"
    "audio/x-musepack"
    "audio/ogg"
    "audio/scpls"
    "audio/x-scpls"
    "audio/vnd.rn-realaudio"
    "audio/wav"
    "audio/x-pn-wav"
    "audio/x-pn-windows-pcm"
    "audio/x-realaudio"
    "audio/x-pn-realaudio"
    "audio/x-ms-wma"
    "audio/x-pls"
    "audio/x-wav"
    "audio/x-ms-asf"
    "application/vnd.ms-asf"
    "audio/x-matroska"
    "application/x-matroska"
    "audio/webm"
    "audio/vorbis"
    "audio/x-vorbis"
    "audio/x-vorbis+ogg"
    "application/x-ogm"
    "application/x-ogm-audio"
    "application/x-shorten"
    "audio/x-shorten"
    "audio/x-ape"
    "audio/x-wavpack"
    "audio/x-tta"
    "audio/AMR"
    "audio/ac3"
    "audio/eac3"
    "audio/amr-wb"
    "audio/flac"
    "audio/mp4"
    "audio/x-pn-au"
    "audio/3gpp"
    "audio/3gpp2"
    "audio/dv"
    "audio/opus"
    "audio/vnd.dts"
    "audio/vnd.dts.hd"
    "audio/x-adpcm"
    "application/x-cue"
    "audio/m3u"
    "audio/*"
  ];
  video = [
    "application/x-ogm-video"
    "application/x-mpegurl"
    "application/vnd.apple.mpegurl"
    "application/x-extension-mp4"
    "video/mpeg"
    "video/x-mpeg2"
    "video/x-mpeg3"
    "video/mp4v-es"
    "video/x-m4v"
    "video/mp4"
    "video/divx"
    "video/vnd.divx"
    "video/msvideo"
    "video/x-msvideo"
    "video/ogg"
    "video/quicktime"
    "video/vnd.rn-realvideo"
    "video/x-ms-afs"
    "video/x-ms-asf"
    "video/x-ms-wmv"
    "video/x-ms-wmx"
    "video/x-ms-wvxvideo"
    "video/x-avi"
    "video/avi"
    "video/x-flic"
    "video/fli"
    "video/x-flc"
    "video/flv"
    "video/x-flv"
    "video/x-theora"
    "video/x-theora+ogg"
    "video/x-matroska"
    "video/mkv"
    "video/webm"
    "video/x-ogm"
    "video/x-ogm+ogg"
    "video/mp2t"
    "video/vnd.mpegurl"
    "video/3gp"
    "video/3gpp"
    "video/3gpp2"
    "video/dv"
    "video/*"
  ];
  models = ["model/stl" "model/3mf"];
  cad = [
    "application/acad"
    "application/x-acad"
    "application/x-autocad"
    "application/autocad_dwg"
    "application/sld"
    "application/sldworks"
    "application/x-sld"
    "image/x-sld"
    "image/vnd.dxf"
    "application/dwg"
    "drawing/dwg"
    "application/x-dwg"
    "image/x-dwg"
    "application/dwf"
    "application/x-dwf"
    "drawing/x-dwf"
    "image/x-dwf"
    "image/vnd.dwf"
    "model/vnd.dwf"
    "image/vnd.dwg"
    "application/vnd.vectorworks"
    "model/iges"
    "application/iges"
    "application/step"
    "model/x.stl-binary"
    "model/vnd.gs-gdl"
    "model/vnd.gs.gdl"
    "model/vnd.dwfx+xps"
  ];
  archives = map (_: "application/${_}") [
    "bzip2"
    "gzip"
    "vnd.android.package-archive"
    "vnd.ms-cab-compressed"
    "vnd.debian.binary-package"
    "x-7z-compressed"
    "x-7z-compressed-tar"
    "x-ace"
    "x-alz"
    "x-ar"
    "x-archive"
    "x-arj"
    "x-brotli"
    "x-bzip-brotli-tar"
    "x-bzip"
    "x-bzip-compressed-tar"
    "x-bzip1"
    "x-bzip1-compressed-tar"
    "x-cabinet"
    "x-cd-image"
    "x-compress"
    "x-compressed-tar"
    "x-cpio"
    "x-chrome-extension"
    "x-deb"
    "x-ear"
    "x-ms-dos-executable"
    "x-gtar"
    "x-gzip"
    "x-gzpostscript"
    "x-java-archive"
    "x-lha"
    "x-lhz"
    "x-lrzip"
    "x-lrzip-compressed-tar"
    "x-lz4"
    "x-lzip"
    "x-lzip-compressed-tar"
    "x-lzma"
    "x-lzma-compressed-tar"
    "x-lzop"
    "x-lz4-compressed-tar"
    "x-ms-wim"
    "x-rar"
    "x-rar-compressed"
    "x-rpm"
    "x-source-rpm"
    "x-rzip"
    "x-rzip-compressed-tar"
    "x-tar"
    "x-tarz"
    "x-tzo"
    "x-stuffit"
    "x-war"
    "x-xar"
    "x-xz"
    "x-xz-compressed-tar"
    "x-zip"
    "x-zip-compressed"
    "x-zstd-compressed-tar"
    "x-zoo"
    "zip"
    "zstd"
  ];
  code = [
    "inode/x-empty"
    "application/x-code-workspace"
    "application/x-shellscript"
    "text/english"
    "text/plain"
    "text/x-makefile"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-csrc"
    "text/x-java"
    "text/x-moc"
    "text/x-pascal"
    "text/x-tcl"
    "text/x-tex"
    "text/x-c"
    "text/x-c++"
    "text/*"
  ];

  browsers =
    map addDesktop ["firefox"];
  editors = map addDesktop ["codium" "lapce" "kate"];
  associations = lib.prioritizeList [
    (lib.genAttrs code (_: editors))
    (lib.genAttrs images (_: ["imv.desktop"]))
    (lib.genAttrs urls (_: browsers))
    (lib.genAttrs readable (_: ["org.gnome.Evince.desktop"]))
    (lib.genAttrs audio (_: ["mpv.desktop"]))
    (lib.genAttrs video (_: ["mpv.desktop"]))
    (lib.genAttrs archives
      (_: map addDesktop ["org.gnome.FileRoller" "thunar"]))
    (lib.genAttrs documents (_: map addDesktop ["writer" "less"]))
    (lib.genAttrs spreadsheets (_: map addDesktop ["calc" "visidata" "less"]))
    (lib.genAttrs slides (_: map addDesktop ["impress" "less"]))
    (lib.genAttrs models (_: map addDesktop ["PrusaSlicer"]))
    (lib.genAttrs ["text/x-gcode"] (_: map addDesktop ["PrusaGcodeviewer"]))
    (lib.genAttrs cad (_: map addDesktop ["org.freecadweb.FreeCAD"]))
    (lib.genAttrs ["application/x-gzip" "application/x-tar"]
      (_: map addDesktop ["tar.gz"]))
    (lib.genAttrs [
      "application/vnd.rar"
      "application/x-rar"
      "application/x-rar-compressed"
    ] (_: map addDesktop ["rar"]))
    {
      "inode/directory" = map addDesktop [
        "lf"
        "ranger"
        "thunar"
        "codium"
        "lapce"
        "less"
      ]; # gets hijacked: https://github.com/microsoft/vscode/issues/41037#issuecomment-369339898
      "x-scheme-handler/mailto" = ["betterbird.desktop"];
      "text/calendar" = ["org.gnome.Calendar.desktop"];
      "application/pdf" = map addDesktop ["org.pwmt.zathura" "less"];
      "text/plain" =
        map addDesktop ["org.gnome.TextEditor" "less" "codium" "lapce"];
      "text/markdown" = map addDesktop ["glow" "less" "codium"];
      "text/org" = map addDesktop ["less" "codium"];
      "application/epub+zip" =
        map addDesktop ["calibre-ebook-viewer" "calibre-ebook-edit"];
      "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
      "application/json" = browsers;
      "text/csv" =
        map addDesktop ["calc" "visidata" "less" "org.gnome.TextEditor"];
      "application/vnd.smart.notebook" = map addDesktop ["less"];
      "application/x-zip" = map addDesktop ["zip"];
      "x-scheme-handler/magnet" = map addDesktop ["webtorrent" "stremio"];
      "x-scheme-handler/irc" = map addDesktop ["halloy"];
      "text/*" = map addDesktop ["pistol"];
    }
    # use pistol as fallback for terminal-based read-only previews
    (lib.genAttrs
      (lib.lists.map (x: x.mime) config.programs.pistol.associations)
      (_: ["pistol"])
    )
  ];
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = associations;
    associations.added = associations;
  };
}
