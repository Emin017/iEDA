final: prev:
let
  findPackage = path: prev.callPackage ./pkgs/${path}/package.nix { };
in
{
  ieda = findPackage "ieda";
  iedaClang = prev.callPackage ./pkgs/iedaClang { };
  glog = findPackage "glog";

  rustpkgs = prev.callPackage ./pkgs/rustpkgs { };
  iir-rust = final.rustpkgs.iir-rust;
  liberty-parser = final.rustpkgs.liberty-parser;
  sdf-parse = final.rustpkgs.sdf_parse;
  spef-parser = final.rustpkgs.spef-parser;
  vcd-parser = final.rustpkgs.vcd_parser;
  verilog-parser = final.rustpkgs.verilog-parser;

  rustpkgs-all = final.symlinkJoin {
    name = "rustpkgs-all";
    paths = with final; [
      iir-rust
      liberty-parser
      sdf-parse
      spef-parser
      vcd-parser
      verilog-parser
    ];
  };

  perfEnv = final.callPackage ./tests/offline/perfEnv.nix { };
  perfBundle = final.callPackage ./tests/offline/bundler.nix { };

  perfDocker = final.callPackage ./tests/docker.nix { };
  gperf2flamegraph = prev.callPackage ./tests/docker/gperf2flamegraph.nix { };
}
