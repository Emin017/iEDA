{
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "vcd_parser";
  version = "0.1.0";
  src = ./../../../src/database/manager/parser/vcd/vcd_parser;

  cargoLock = {
    lockFile = ./../../../src/database/manager/parser/vcd/vcd_parser/Cargo.lock;
  };

  cargoHash = "sha256-xcfVzDrnW4w3fU7qo6xzSQeIH8sEbEyzPF92F5tDcAk=";

  doCheck = false;

  nativeBuildInputs = [ rustPlatform.bindgenHook ];
}
