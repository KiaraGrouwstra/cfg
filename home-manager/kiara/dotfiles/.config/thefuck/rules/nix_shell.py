# https://github.com/thenbe/thefuck/blob/nix-shell-new/thefuck/rules/nix_shell.py
from thefuck.specific.nix import nix_available
import subprocess

enabled_by_default = nix_available

# Set the priority just ahead of `fix_file` rule, which can generate low quality matches due
# to the sheer amount of paths in the nix store.
priority = 999


def get_nixpkgs_names(bin):
    """
    Returns the name of the Nix package that provides the given binary. It uses the
    `command-not-found` binary to do so, which is how nix-shell generates it's own suggestions.
    """

    result = subprocess.run(
        ["command-not-found", bin], stderr=subprocess.PIPE, universal_newlines=True
    )

    # The suggestion, if any, will be found in stderr. Upstream definition: https://github.com/NixOS/nixpkgs/blob/b6fbd87328f8eabd82d65cc8f75dfb74341b0ace/nixos/modules/programs/command-not-found/command-not-found.nix#L48-L90
    text = result.stderr

    # return early if binary is not available through nix
    if "nix-shell" not in text:
        return []

    nixpkgs_names = [
        line.split()[-1] for line in text.splitlines() if "nix-shell -p" in line
    ]
    return nixpkgs_names


def match(command):
    bin = command.script_parts[0]
    return (
        "command not found" in command.output  # only match commands which had exit code: 127                   # noqa: E501
        and get_nixpkgs_names(bin)             # only match commands which could be made available through nix  # noqa: E501
    )


def get_new_command(command):
    bin = command.script_parts[0]
    nixpkgs_names = get_nixpkgs_names(bin)
    args = " ".join(command.script_parts[1:])  # everything but the command name

    # (unified CLI) Enters a non-interactive shell with the given package available, then runs the given command.
    nix_shell = "nix shell nixpkgs#{} --command {}".format("{}", command.script)

    # (unified CLI) Enters an interactive shell with the given package available, but does not run any command.
    nix_shell_vanilla = "nix shell nixpkgs#{}"

    # (original CLI) Enters a non-interactive shell with the given package available, then runs the given command.
    nix_shell_original = 'nix-shell -p {} --run "{}"'.format("{}", command.script)

    # (unified CLI) Enters a non-interactive shell with the given package available, then runs the given command.
    if args:
        nix_run = "nix run nixpkgs#{} -- {}".format("{}", args)
    else:
        nix_run = "nix run nixpkgs#{}"

    patterns = [
        nix_run,
        nix_shell_vanilla,
        nix_shell_original,
        # nix_shell, # nix_run is generally preferred over this
    ]

    commands = [pattern.format(name) for name in nixpkgs_names for pattern in patterns]
    return commands
