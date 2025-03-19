{
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "verilog-parser";
  version = "0.1.0";
  src = ./../../../src/database/manager/parser/verilog/verilog-rust/verilog-parser;

  cargoLock = {
    lockFile = ./../../../src/database/manager/parser/verilog/verilog-rust/verilog-parser/Cargo.lock;
  };

  cargoHash = "sha256-ooxY8Q8bfD+klBGfpTDD3YyWptEOGGHDoyamhjlSNTM=";

  doCheck = false;

  nativeBuildInputs = [ rustPlatform.bindgenHook ];
}
