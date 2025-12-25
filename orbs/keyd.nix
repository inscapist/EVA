{
  stdenv,
  fetchFromGitHub,
  systemd,
  ...
}:

let
  version = "2.4.3pp";

  src = fetchFromGitHub {
    owner = "rvaiya";
    repo = "keyd";
    rev = "master";
    sha256 = "sha256-l7yjGpicX1ly4UwF7gcOTaaHPRnxVUMwZkH70NDLL5M=";
  };
in
stdenv.mkDerivation {
  pname = "keyd";
  inherit version src;

  postPatch = ''
    substituteInPlace Makefile \
      --replace /usr/local ""
  '';

  installFlags = [ "DESTDIR=${placeholder "out"}" ];

  buildInputs = [ systemd ];

  enableParallelBuilding = true;

  postInstall = ''
    rm -rf $out/etc
  '';

  meta = {
    description = "Keyd";
  };
}
