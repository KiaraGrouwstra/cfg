{pkgs, ...}:
pkgs.writeShellScriptBin "xterm-256color" ''
  xdg-terminal-exec $@
''
