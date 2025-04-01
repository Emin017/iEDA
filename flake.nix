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
          _module.args.pkgs =
            let
              overlay = import ./nix/overlay.nix;
            in
            import inputs.nixpkgs {
              inherit system;
              overlays = [
                overlay
              ];
              # config = { };
            };
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              nixfmt.package = pkgs.nixfmt-rfc-style;
            };
            flakeCheck = true;
          };
          packages = {
            default = pkgs.ieda;
            inherit (pkgs)
              ieda
              iedaClang
              perfDocker
              gperf2flamegraph
              perfEnv
              perfBundle
              rustpkgs-all
              ;
          };
          devShells = {
            default =
              with pkgs;
              mkShell {
                inputsFrom = [ config.packages.ieda ];
                buildInputs = [
                  cmake
                  gnumake
                  clang-tools
                  cargo
                  hyperfine
                  inferno
                  gperftools
                ];
              };
            rtl2gds = pkgs.mkShell {
              buildInputs = with pkgs; [
                uv
                yosys
              ];
              shellHook = ''
                export PYTHONPATH=`pwd`/RTL2GDS/src
              '';
            };
          };
        };
    };
}
