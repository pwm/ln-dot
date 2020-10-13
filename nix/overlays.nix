{ sources }:
[
  (final: prev: {
    ln-dot = (import ./packages.nix { pkgs = prev; });
  })
]
