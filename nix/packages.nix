{ pkgs }: with pkgs;
let
  src-filter = import ./lib/src-filter.nix;

  # A view of the project's source code, with only the Haskell dependencies
  ln-dot-src = src-filter.filter {
    path = ../.;
    allow = [
      (src-filter.matchExt "hs")
      ../app
      ../src
      ../src/LnDot
      ../.hlint.yaml
      ../cabal.project
      ../hie.yaml
      ../ln-dot.cabal
      ../package.yaml
    ];
  };

  haskellPackages = haskell.packages.ghc883.override {
    overrides =
      let
        generated = haskell.lib.packagesFromDirectory {
          directory = ./packages;
        };
        manual = _hfinal: hprev: {
          ln-dot = haskell.lib.overrideCabal hprev.ln-dot (_drv: {
            src = ln-dot-src;
            postConfigure = ''
              ${hlint}/bin/hlint ${ln-dot-src}
            '';
          });
        };
      in
      lib.composeExtensions generated manual;
  };

  ghc = haskellPackages.ghc.withPackages (_ps:
    haskell.lib.getHaskellBuildInputs haskellPackages.ln-dot
  );
in
{
  exe = haskellPackages.ln-dot;

  shell = buildEnv {
    name = "ln-dot-env";
    paths = [
      ghc
      cabal-install
      cabal2nix
      hlint
      ormolu
      niv
      graphviz
    ];
  };
}
