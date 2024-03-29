{pkgs, ...}:
pkgs.local-ai.override {
  with_tts = true;
  with_openblas = true;
  # with_clblas = true;
}
