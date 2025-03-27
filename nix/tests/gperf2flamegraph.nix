{
  pkgs,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage {
  pname = "gperf2flamegraph";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "Emin017";
    repo = "gperf2flamegraph";
    rev = "3f91c436e019925ec95ef88991162ddda9608ecb";
    sha256 = "sha256-3QmpcXZcll2mNNq3tpbgcrZ97ZeaTgQMSIy+AklMoLk=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-2vGRoLlC26BNooREyRLVpeKXclApXTf9Ykfut0mW8hU=";

  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    openssl
  ];
}
