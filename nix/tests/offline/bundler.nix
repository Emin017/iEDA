{
  pkgs,
}:
let
  shell = pkgs.mkShell {
    buildInputs = with pkgs; [
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
    nativeBuildInputs = with pkgs; [
      cmake
      ninja
      flex
      bison
      tcl
    ];
  };
  closure = pkgs.closureInfo {
    rootPaths = [ shell.drvPath ];
  };
in
pkgs.runCommand "env"
  {
    pname = "env";
    meta.mainProgram = "env";
  }
  ''
    mkdir -p $out/bin
    cat > $out/bin/env <<EOF
    #!${pkgs.runtimeShell}
    export PATH=$PATH:${
      pkgs.lib.makeBinPath (
        with pkgs;
        [
          nix
          bashInteractive
        ]
      )
    }
    NIX_STATE_DIR=/nix/var/nix nix-store --load-db < ${closure}/registration
    exec nix-shell --option substituters "" ${shell.drvPath}
    EOF

    chmod +x $out/bin/env
  ''
