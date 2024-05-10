{
  lib,
  config,
  ...
}: let
  letters = ["a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"];
  addUpper = lib.mapVals (attrs: attrs // lib.mapAttrs' (name: value: lib.nameValuePair (lib.toUpper name) (lib.toUpper value)) attrs);
  keys = {
    qwerty = lib.genAttrs letters (k: k);
    workman = {
      q = "q";
      w = "d";
      e = "r";
      r = "w";
      t = "b";
      y = "j";
      u = "f";
      i = "u";
      o = "p";
      p = ";";
      a = "a";
      s = "s";
      d = "h";
      f = "t";
      g = "g";
      h = "y";
      j = "n";
      k = "e";
      l = "o";
      ";" = "i";
      z = "z";
      x = "x";
      c = "m";
      v = "c";
      b = "v";
      n = "k";
      m = "l";
    };
  };
  cfg = config.keyboard;
in {
  options.keyboard = {
    active = lib.mkOption {default = "qwerty";};
    keys = lib.mkOption {default = null;};
    vi = lib.mkOption {default = null;};
  };

  config.keyboard.keys = (addUpper keys)."${cfg.active}";
  config.keyboard.vi =
    (addUpper (lib.mapAttrs (k: v: keys."${k}" // v) {
      qwerty = {};
      workman =
        # mnemonic
        keys.qwerty
        //
        # qwerty positions
        # { inherit (keys.workman) h j k l j n; } //
        lib.genAttrs ["h" "j" "k" "l" "y" "n"] (k: keys.workman."${k}")
        //
        # remapped
        {
          o = "l";
          e = "h";
        };
    }))
    ."${cfg.active}";
}
