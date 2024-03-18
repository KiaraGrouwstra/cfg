{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    ## file handling / metadata
    xdg-utils

    ## compression
    zip
    unzip
    zlib
    unrar-free

    ## file sharing
    nextcloud-client

    # security
    gnome.seahorse

    # previews
    viu
    timg
  ];

  services.syncthing.enable = true;

  # TODO: reconciliate with MIME associations
  programs.pistol = {
    enable = true;
    # if i wanna use pistol for previews thru lf/fzf, these should be pure
    # read-only operations, so no like starting torrent downloads.
    associations = with (import ../../commands/pkgs.nix {inherit pkgs;});
      lib.lists.map (
        # append ` %pistol-filename%` to command
        {command, ...} @ attrs: attrs // {command = "${command} %pistol-filename%";}
      ) [
        {
          mime = "application/json";
          command = "${bat} --color=always";
        }
        {
          mime = "application/*";
          command = hexyl;
        }
        {
          mime = "text/markdown";
          command = "${glow} -s dark";
        }
        {
          mime = "image/*";
          command = viu;
        }
        {
          mime = "text/*";
          command = "${bat} --color=always";
        }
        {
          mime = "video/*";
          command = timg;
        }
        {
          mime = "inode/directory";
          command = "${eza} --icons --color=always --tree --level 1 --group-directories-first -a --git-ignore --header --git";
        }
      ];
  };

  programs.lf = {
    enable = true;
    settings = {
      number = true;
      ratios = [1 1 2];
      tabstop = 4;
    };
    extraConfig = ''
      set previewer ~/.config/lf/lf_kitty_preview
      set cleaner ~/.config/lf/lf_kitty_clean
    '';
    commands = {
      get-mime-type = ''%xdg-mime query filetype "$f"'';
      open = "$$OPENER $f";
    };
    keybindings = {
      D = "trash";
      U = "!du -sh";
      gh = "cd ~";
      i = "$less $f";
    };
    cmdKeybindings = {"<c-g>" = "cmd-escape";};
    previewer = {
      # Key to bind to the script at `previewer.source` and pipe through less. Setting to null will not bind any key.
      keybinding = "i";
      # Script or executable to use to preview files. Sets lf's `previewer` option.
      source = pkgs.writeShellScript "pv.sh" ''
        #!/bin/sh

        case "$1" in
            *.tar*) tar tf "$1";;
            *.zip) unzip -l "$1";;
            *.rar) unrar l "$1";;
            *.7z) 7z l "$1";;
            *.pdf) pdftotext "$1" -;;
            *) highlight -O ansi "$1" || cat "$1";;
        esac
      '';
    };
  };
}
