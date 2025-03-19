{
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "spef-parser";
  version = "0.2.5";
  src = ./../../../src/database/manager/parser/spef/spef-parser;

  cargoLock = {
    lockFile = ./../../../src/database/manager/parser/spef/spef-parser/Cargo.lock;
  };

  cargoHash = "sha256-o83rK7laEUMAeNIUZH0sARe1MUK9j+vJIDLJ8TOSOxU=";

  nativeBuildInputs = [ rustPlatform.bindgenHook ];
}
