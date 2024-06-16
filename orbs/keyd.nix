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
    # rev = "v" + version;
    # hash = "sha256-NhZnFIdK0yHgFR+rJm4cW+uEhuQkOpCSLwlXNQy6jas=";
    rev = "master";
    sha256 = "sha256-0zlz4qlfj86LdzXPQFo8j8AUdLn2lScNXRGO7x4aHVg=";
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
