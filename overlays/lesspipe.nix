{pkgs, ...}:
pkgs.lesspipe.overrideAttrs (oa: {
  patches =
    (oa.patches or [])
    ++ [
      ./lesspipe.patch
    ];
})
