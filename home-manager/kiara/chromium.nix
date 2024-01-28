{ pkgs, ... }:

{

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium; # thorium-browser
    dictionaries = with pkgs.hunspellDictsChromium; [
      en_US
    ];
    commandLineArgs = [
      "--enable-logging=stderr"
      "--ignore-gpu-blocklist"
    ];
    # https://chrome.google.com/webstore/category/extensions
    extensions = [
    ];
  };

}
