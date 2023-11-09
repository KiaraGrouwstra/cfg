{ pkgs, ... }:

let
  uncompress = command: ''echo %f \| while read -r file \; do echo "\$\(dirname \$file\)/\$\(basename \$file .tar.gz\)" \| while read -r base \; do mkdir -p \$base \&\& ${command} \&\& xdg-open \$base \& \; done \; done'';
  commandDesktop = (name: command: mimeTypes:
    (pkgs.makeDesktopItem {
      name = name;
      desktopName = name;
      genericName = name;
      exec = "${pkgs.kitty}/bin/kitty ${command}";
      icon = "utilities-terminal";
      categories = [ "Office" "Viewer" ]; # https://askubuntu.com/a/674411/332744
      mimeTypes = mimeTypes;
    })
  );
in

{

  home.packages = with pkgs; [

    (commandDesktop "less" "${less}/bin/less" [
      "text/plain"
      "text/html"
      "text/markdown" # mdcat / pandoc
      "application/json" # jq
      "application/vnd.smart.notebook" # pandoc
    ])

    (commandDesktop "glow" "${glow}/bin/glow" [
      "text/markdown"
    ])

    (commandDesktop "tar" (uncompress ''${gnutar}/bin/tar --directory=\$base -xvf \$file'') [
      "application/x-gzip"
      "application/x-tar"
    ])

    (commandDesktop "zip" (uncompress ''${unzip}/bin/unzip \$file -d \$base'') [
      "application/x-zip"
    ])

  ];

}
