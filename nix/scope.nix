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
  }
)
