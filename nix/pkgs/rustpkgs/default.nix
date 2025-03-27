{ rustPlatform }:
let
  mkRustpkgs = _: p: rustPlatform.buildRustPackage p;
in
(builtins.mapAttrs mkRustpkgs {
  iir-rust = {
    pname = "iir-rust";
    version = "0.1.3";
    src = ./../../../src/operation/iIR/source/iir-rust/iir;
    cargoBuildType = "release";

    cargoLock = {
      lockFile = ./../../../src/operation/iIR/source/iir-rust/iir/Cargo.lock;
    };

    cargoHash = "sha256-xyNaUTPvU21yOdkQq8vdnHCyLzcpDAFAje0R/gDqliU=";

    doCheck = false;

    nativeBuildInputs = [ rustPlatform.bindgenHook ];
  };
  liberty-parser = {
    pname = "liberty-parser";
    version = "0.1.3";
    src = ./../../../src/database/manager/parser/liberty/lib-rust/liberty-parser;
    cargoBuildType = "release";

    cargoLock = {
      lockFile = ./../../../src/database/manager/parser/liberty/lib-rust/liberty-parser/Cargo.lock;
    };

    cargoHash = "sha256-nRIOuSz5ImENvKeMAnthmBo+2/Jy5xbM66xkcfVCTMI=";

    doCheck = false;
    nativeBuildInputs = [ rustPlatform.bindgenHook ];
  };
  sdf_parse = {
    pname = "sdf_parse";
    version = "0.1.0";
    src = ./../../../src/database/manager/parser/sdf/sdf_parse;
    cargoBuildType = "release";

    cargoLock = {
      lockFile = ./../../../src/database/manager/parser/sdf/sdf_parse/Cargo.lock;
    };

    cargoHash = "sha256-PORA/9DDIax4lOn/pzmi7Y8mCCBUphMTzbBsb64sDl0=";

    nativeBuildInputs = [ rustPlatform.bindgenHook ];
  };
  spef-parser = {
    pname = "spef-parser";
    version = "0.2.5";
    src = ./../../../src/database/manager/parser/spef/spef-parser;
    cargoBuildType = "release";

    cargoLock = {
      lockFile = ./../../../src/database/manager/parser/spef/spef-parser/Cargo.lock;
    };

    cargoHash = "sha256-o83rK7laEUMAeNIUZH0sARe1MUK9j+vJIDLJ8TOSOxU=";

    nativeBuildInputs = [ rustPlatform.bindgenHook ];
  };
  vcd_parser = {
    pname = "vcd_parser";
    version = "0.1.0";
    src = ./../../../src/database/manager/parser/vcd/vcd_parser;
    cargoBuildType = "release";

    cargoLock = {
      lockFile = ./../../../src/database/manager/parser/vcd/vcd_parser/Cargo.lock;
    };

    cargoHash = "sha256-xcfVzDrnW4w3fU7qo6xzSQeIH8sEbEyzPF92F5tDcAk=";

    doCheck = false;

    nativeBuildInputs = [ rustPlatform.bindgenHook ];
  };
  verilog-parser = {
    pname = "verilog-parser";
    version = "0.1.0";
    src = ./../../../src/database/manager/parser/verilog/verilog-rust/verilog-parser;
    cargoBuildType = "release";

    cargoLock = {
      lockFile = ./../../../src/database/manager/parser/verilog/verilog-rust/verilog-parser/Cargo.lock;
    };

    cargoHash = "sha256-ooxY8Q8bfD+klBGfpTDD3YyWptEOGGHDoyamhjlSNTM=";

    doCheck = false;

    nativeBuildInputs = [ rustPlatform.bindgenHook ];
  };
})
