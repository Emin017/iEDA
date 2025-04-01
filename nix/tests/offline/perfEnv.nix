{
  pkgs,
  bash,
  busybox,
  glog,
  iir-rust,
  sdf-parse,
  spef-parser,
  vcd-parser,
  verilog-parser,
  liberty-parser,
  gtest,
  gflags,
  boost,
  onnxruntime,
  eigen,
  yaml-cpp,
  libunwind,
  metis,
  gmp,
  tcl,
  zlib,
  gperftools,
  cmake,
  ninja,
  flex,
  bison,
  python3,
}:
let
  shell = pkgs.mkShell {
    buildInputs = [
      iir-rust
      sdf-parse
      spef-parser
      vcd-parser
      verilog-parser
      liberty-parser
      gtest
      glog
      gflags
      boost
      onnxruntime
      eigen
      yaml-cpp
      libunwind
      metis
      gmp
      tcl
      zlib
      gperftools
    ];
    nativeBuildInputs = [
      cmake
      ninja
      flex
      bison
      python3
      # Ensure bash shell is available in the environment
      bash
    ];
  };
in

pkgs.callPackage ./env.nix {
  paths = [ shell.drvPath ];
  program = pkgs.writeShellApplication {
    name = "perfEnv";
    runtimeInputs = with pkgs; [
      nix
      bash
      busybox
      cmake
      ninja
      flex
      bison
      python3
    ];
    text = ''
      NIX_BUILD_SHELL=bash exec nix-shell --option substituters "" ${shell.drvPath}
    '';
  };
}
