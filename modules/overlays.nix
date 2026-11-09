{
  flake.overlays.default = final: _prev: {
    tack = final.callPackage ../pkgs/tack.nix { };
  };
}
