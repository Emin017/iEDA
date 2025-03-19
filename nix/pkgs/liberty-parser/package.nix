{
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "liberty-parser";
  version = "0.1.3";
  src = ./../../../src/database/manager/parser/liberty/lib-rust/liberty-parser;

  cargoLock = {
    lockFile = ./../../../src/database/manager/parser/liberty/lib-rust/liberty-parser/Cargo.lock;
  };

  cargoHash = "sha256-nRIOuSz5ImENvKeMAnthmBo+2/Jy5xbM66xkcfVCTMI=";

  doCheck = false;

  nativeBuildInputs = [ rustPlatform.bindgenHook ];
}
