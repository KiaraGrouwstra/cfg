{
  pkgs,
  lib,
  ...
}:
pkgs.cudaPackages.overrideScope (_final: _prev: let
  inherit (pkgs) zluda;
in
  lib.genAttrs [
    "libcublas"
    "cudatoolkit"
    "cudnn"
    "libcusparse"
    "libcufft"
    "libnccl"
    "cuda_nvml_dev"
    # the following seem not part of zluda yet so overriding would amount to a no-op (if not actively making things explode):
    # "cuda_nvcc"
    # "tensorrt"
    # "libnpp"
    # "libcusolver"
    # "libcurand"
    # "libcufile"
    # "libcutensor"
    # "cuda_nvvp"
    # "cuda_nvtx"
    # "cuda_nvrtc"
    # "cuda_nvprune"
    # "cuda_nvprof"
    # "cuda_nvdisasm"
    # "cuda_nsight"
    # "cuda_nvgdb"
    # # "cuda_cudart"
    # # "cuda_cccl"
  ] (_: zluda)
  // {
    cuda_cccl = {
      dev = zluda;
    };
    cuda_cudart = {
      dev = zluda;
      lib = zluda;
      static = zluda;
    };
    # libcublas = {
    #   dev = zluda;
    #   lib = zluda;
    #   static = zluda;
    # };
    backendStdenv = pkgs.stdenv;
  })
