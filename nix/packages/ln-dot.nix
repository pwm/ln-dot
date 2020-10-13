{ mkDerivation, aeson, base, bytestring, either, generic-lens
, graphviz, hpack, lens, stdenv, text
}:
mkDerivation {
  pname = "ln-dot";
  version = "0.1.0.0";
  src = builtins.path { path = ../..; name = "ln-dot"; };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base bytestring either generic-lens graphviz lens text
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson base bytestring either generic-lens graphviz lens text
  ];
  prePatch = "hpack";
  homepage = "https://github.com/pwm/ln-dot#readme";
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
