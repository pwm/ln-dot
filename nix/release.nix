{ system ? builtins.currentSystem }:
let
  pkgs = import ./. { inherit system; };
in
# pkgs.ln-dot
pkgs.ln-dot.haskellPackages.ln-dot
