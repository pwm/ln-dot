{ sources }:
[
  (_final: prev: {
    ln-dot = (import ./packages.nix { pkgs = prev; });
  })
]
