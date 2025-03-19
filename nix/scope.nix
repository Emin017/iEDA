{ lib, newScope, ... }:
lib.makeScope newScope (
  scope:
  let
    findPackage = path: scope.callPackage ./pkgs/${path}/package.nix { };
  in
  {
    ieda = findPackage "ieda";
    iedaClang = scope.callPackage ./pkgs/iedaClang { };
    glog = findPackage "glog";
    iir-rust = findPackage "iir-rust";
    liberty-parser = findPackage "liberty-parser";
    sdf-parse = findPackage "sdf-parse";
    spef-parser = findPackage "spef-parser";
    vcd-parser = findPackage "vcd-parser";
    verilog-parser = findPackage "verilog-parser";
  }
)
