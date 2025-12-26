{
  fetchzip,
  stdenvNoCC,
  ...
}:

let
  pname = "overops";
  version = "0.1.5";

  src = fetchzip {
    url = "https://storage.googleapis.com/talenox-tools/overops/binary/${version}/overops_${version}_linux_amd64.zip";
    hash = "sha256-cFkMNLJaxRHG4x08KFcP5JFbTMiicn4t++m8JX/rG2Y=";
    stripRoot = false;
  };
in
stdenvNoCC.mkDerivation {
  inherit
    pname
    src
    version
    ;

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 ${src}/overops $out/bin/overops
    install -Dm644 ${src}/README.md $out/share/doc/${pname}/README.md

    runHook postInstall
  '';

  meta = {
    description = "Overops CLI";
    mainProgram = "overops";
    platforms = [ "x86_64-linux" ];
  };
}
