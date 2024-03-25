#!/usr/bin/env -S nix shell nixpkgs#fontpreview --command sh
# pick a font and preview it
fontpreview --fg-color='#fff' --bg-color='#000' --font-size='30' --preview-text="ABCDEFGHIJKLMNOPQRSTUVWXYZ\nabcdefghijklmnopqrstuvwxyz\n1234567890!@\$\%(){}[]\nたとえ　火の中　水の中\n草の中　森の中　土の中\n雲の中　あのコの\nスカートの中　(キャ～)"
