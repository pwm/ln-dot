{ pkgs }: with pkgs;
let
  ln-dot = rec {
    haskellPackages = haskell.packages.ghc883.override {
      overrides =
        let
          generated = haskell.lib.packagesFromDirectory {
            directory = ./packages;
          };
          manual = haskellPackagesNew: haskellPackagesOld: { };
        in
        lib.composeExtensions generated manual;
    };

    ghc = ln-dot.haskellPackages.ghc.withPackages (p:
      ln-dot.haskellPackages.ln-dot.getBuildInputs.haskellBuildInputs
    );

    devEnv = buildEnv {
      name = "ln-dot-env";
      paths = [
        ghc
        cabal-install
        niv
        graphviz
      ];
    };
  };
in
ln-dot
