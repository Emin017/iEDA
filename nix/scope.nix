{ lib, newScope, ... }:
lib.makeScope newScope (
  scope:
  let
    findPackage = path: scope.callPackage ./pkgs/${path}/package.nix { };
    rustpkgs = scope.callPackage ./pkgs/rustpkgs { };
  in
  {
    ieda = findPackage "ieda";
    iedaClang = scope.callPackage ./pkgs/iedaClang { };
    glog = findPackage "glog";
    iir-rust = rustpkgs.iir-rust;
    liberty-parser = rustpkgs.liberty-parser;
    sdf-parse = rustpkgs.sdf_parse;
    spef-parser = rustpkgs.spef-parser;
    vcd-parser = rustpkgs.vcd_parser;
    verilog-parser = rustpkgs.verilog-parser;

    gperf2flamegraph = scope.callPackage ./tests/gperf2flamegraph.nix { };
    perf-docker = scope.callPackage ./tests/docker.nix { };
    perf-run-iTO = scope.writeShellScriptBin "perf-run-iTO" ''
      cp nix/tests/perf-iEDA.sh scripts/design/sky130_gcd/
      cd scripts/design/sky130_gcd/ && ./run_iEDA.sh
      ./perf-iEDA.sh
    '';
  }
)
