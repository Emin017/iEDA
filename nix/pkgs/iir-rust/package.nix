{
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "iir-rust";
  version = "0.1.3";
  src = ./../../../src/operation/iIR/source/iir-rust/iir;

  cargoLock = {
    lockFile = ./../../../src/operation/iIR/source/iir-rust/iir/Cargo.lock;
  };

  cargoHash = "sha256-xyNaUTPvU21yOdkQq8vdnHCyLzcpDAFAje0R/gDqliU=";

  doCheck = false;

  nativeBuildInputs = [ rustPlatform.bindgenHook ];
}
