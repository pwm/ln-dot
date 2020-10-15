{ system ? builtins.currentSystem }:
let
  pkgs = import ./nix { inherit system; };
in
with pkgs; mkShell {
  buildInputs = [
    ln-dot.shell
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${ln-dot.shell}/lib:$LD_LIBRARY_PATH
  '';
}
