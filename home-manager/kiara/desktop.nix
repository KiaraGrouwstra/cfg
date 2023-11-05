{ pkgs, ... }:

{

  home.packages = with pkgs; [

    (makeDesktopItem {
      name = "less";
      desktopName = "Less";
      genericName = "Less";
      terminal = true;
      exec = "${kitty}/bin/kitty ${less}/bin/less";
      icon = "utilities-terminal";
      categories = [ "Office" "Viewer" ]; # https://askubuntu.com/a/674411/332744
      mimeTypes = [
        "text/plain"
        "text/html"
        "text/markdown" # mdcat / pandoc
        "application/json" # jq
        "application/vnd.smart.notebook" # pandoc
      ];
    })

    (makeDesktopItem {
      name = "glow";
      desktopName = "glow";
      genericName = "glow";
      terminal = true;
      exec = "${kitty}/bin/kitty ${glow}/bin/glow";
      icon = "utilities-terminal";
      categories = [ "Office" "Viewer" ];
      mimeTypes = [
        "text/markdown"
      ];
    })

  ];

}
