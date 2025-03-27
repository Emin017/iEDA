{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      parts,
      treefmt-nix,
      ...
    }:
    parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              nixfmt.package = pkgs.nixfmt-rfc-style;
            };
            flakeCheck = true;
          };
          packages =
            let
              scope = pkgs.callPackage ./nix/scope.nix { };
            in
            {
              default = scope.ieda;
              inherit (scope)
                ieda
                iedaClang
                iir-rust
                liberty-parser
                spef-parser
                ;
            };
          devShells.default =
            with pkgs;
            mkShell {
              inputsFrom = [ config.packages.ieda ];
              nativeBuildInputs = [
                cmake
                gnumake
                clang-tools
                cargo
                hyperfine
                inferno
                gperftools
              ];
            };
        };
    };
}
