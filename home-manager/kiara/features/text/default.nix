{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    ./helix.nix
  ];

  home.packages =
    [
      ## command-line document viewers / editors
      pkgs.unixtools.column # lesspipe
    ]
    ++ lib.attrValues {
      inherit
        (pkgs)
        ## text editors
        
        vim
        amp
        gnome-text-editor
        ## document viewers / editors
        
        evince
        calibre
        libreoffice-fresh
        yarr
        ;
    };

  programs.less.keys =
    if config.keyboard.active == "workman"
    then lib.readFile "${inputs.workman-vim}/lesskey"
    else "";

  programs.lesspipe.enable = true;
}
