{
  lib,
  config,
  ...
}:
with config.commands; {
  # TODO: reconciliate with MIME associations
  programs.pistol = {
    enable = true;
    # if i wanna use pistol for previews thru fzf or file managers, these should be pure
    # read-only operations, so no like starting torrent downloads.
    associations =
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
}
