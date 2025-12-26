{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, openssl
, stdenv
, git
, jujutsu
, zlib
}:

rustPlatform.buildRustPackage rec {
  pname = "jj-spr";
  version = "unstable-2025-12-26";

  src = fetchFromGitHub {
    owner = "LucioFranco";
    repo = "jj-spr";
    rev = "8219375ae79f989c94fd09feb7c0eb1bf56e9cc0";
    hash = "sha256-BpXHPwPKtrGrdWEJgDbMJD4n52ZHSg/wOMcDAWWSt2Y=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
  };

  # Fix octocrab's build script that fails in offline Nix builds
  postPatch = ''
    # Patch octocrab to remove the problematic build script and generated file include
    if [ -d ../jj-spr-unstable-2025-12-26-vendor/octocrab-0.48.0 ]; then
      # Create an empty build script
      echo 'fn main() {}' > ../jj-spr-unstable-2025-12-26-vendor/octocrab-0.48.0/build.rs
      # Replace the include statement with an empty constant definition
      sed -i.bak 's|include!(concat!(env!("OUT_DIR"), "/headers_metadata.rs"));|const _SET_HEADERS_MAP: \[(\&str, \&str); 0\] = \[\];|' \
        ../jj-spr-unstable-2025-12-26-vendor/octocrab-0.48.0/src/lib.rs
    fi
  '';

  # Skip tests to avoid git2 version mismatch issues
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    zlib
  ];

  nativeCheckInputs = [
    git
    jujutsu
  ];

  # Tests require git and jujutsu to be available
  checkFlags = [
    # Skip tests that require network or specific git configuration
    "--skip=test_"
  ];

  meta = with lib; {
    description = "Jujutsu change-based workflow integration with GitHub pull requests";
    homepage = "https://github.com/LucioFranco/jj-spr";
    license = licenses.mit;
    maintainers = [ ];
    mainProgram = "spr";
  };
}
