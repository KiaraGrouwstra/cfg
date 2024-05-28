{pkgs, ...}:
pkgs.writeShellScriptBin "x-terminal-emulator" ''
  xdg-terminal-exec $@
''
