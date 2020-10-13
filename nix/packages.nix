{ pkgs }: with pkgs;
let
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

  ghc = haskellPackages.ghc.withPackages (p:
    haskellPackages.ln-dot.getBuildInputs.haskellBuildInputs
  );
in
{
  exe = haskellPackages.ln-dot;

  devEnv = buildEnv {
    name = "ln-dot-env";
    paths = [
      ghc
      cabal-install
      niv
      graphviz
    ];
  };
}
