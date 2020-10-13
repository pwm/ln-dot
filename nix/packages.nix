{ pkgs }: with pkgs;
let
  src-filter = import ./src-filter.nix;

  # A view of the project's source code, with only the Haskell dependencies
  ln-dot-src = src-filter.filter {
    path = ../.;
    allow = [
      (src-filter.matchExt "hs")
      ../app
      ../ln-dot.cabal
      ../package.yaml
      ../src
      ../src/LnDot
    ];
  };

  haskellPackages = haskell.packages.ghc883.override {
    overrides =
      let
        generated = haskell.lib.packagesFromDirectory {
          directory = ./packages;
        };
        manual = haskellPackagesNew: haskellPackagesOld: {
          # Inject the filtered source into the package
          ln-dot = haskellPackagesOld.ln-dot.overrideAttrs (attrs: {
            src = ln-dot-src;
          });
        };
      in
      lib.composeExtensions generated manual;
  };

  ghc = haskellPackages.ghc.withPackages (p:
    haskellPackages.ln-dot.getBuildInputs.haskellBuildInputs
  );
in
{
  exe = haskellPackages.ln-dot;

  # Check the source code with hlint
  hlint = pkgs.runCommand "hlint" {} ''
    ${pkgs.hlint}/bin/hlint ${ln-dot-src} | tee $out
  '';

  devEnv = buildEnv {
    name = "ln-dot-env";
    paths = [
      ghc
      cabal-install
      cabal2nix
      hlint
      niv
      graphviz
    ];
  };
}
