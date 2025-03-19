{
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "sdf_parse";
  version = "0.1.0";
  src = ./../../../src/database/manager/parser/sdf/sdf_parse;

  cargoLock = {
    lockFile = ./../../../src/database/manager/parser/sdf/sdf_parse/Cargo.lock;
  };

  cargoHash = "sha256-PORA/9DDIax4lOn/pzmi7Y8mCCBUphMTzbBsb64sDl0=";

  nativeBuildInputs = [ rustPlatform.bindgenHook ];
}
