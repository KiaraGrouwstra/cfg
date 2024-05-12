{pkgs, ...}:
pkgs.local-ai.override {
  with_tts = true;
  with_clblas = true;
  # with_cublas = true;  # on amd needs zluda
}
