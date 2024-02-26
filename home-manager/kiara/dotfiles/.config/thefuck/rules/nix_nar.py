from thefuck.specific.nix import nix_available
import re

enabled_by_default = nix_available

pattern = re.compile("expected '.*?(sha\d+-[^=]+=).*?', got '.*?(sha\d+-[^=]+=).*?'$")

def match(command):
    return (
        "NAR hash mismatch in input" in command.output
    )

def get_new_command(command):
    result = pattern.search(command.output)
    if result:
        old_hash = result.group(1)
        new_hash = result.group(2)
        return [
            "sed -i -e s%{}%{}% {flake.lock,**/*.nix}; {}".format(old_hash, new_hash, command.script)
        ]
    else:
        return []
