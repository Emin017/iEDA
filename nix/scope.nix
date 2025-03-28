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

    convertGperf = scope.writeShellScriptBin "perf2flamegraph" ''
      #!/usr/bin/env bash
        set -e
        local executable=$1
        local gperf_file=$2
        local output_name=$3
        ${scope.gperf2flamegraph}/bin/gperf2flamegraph \
          --svg-output $output_name.svg \
          --text-output $output_name.png \
          $executable $gperf_file
    '';
  }
)
