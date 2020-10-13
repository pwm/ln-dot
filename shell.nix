{ system ? builtins.currentSystem }:
let
  pkgs = import ./nix { inherit system; };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.ln-dot.devEnv
  ];
}
