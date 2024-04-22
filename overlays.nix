{ flake, system, lib, ... }:

let
  inherit (flake) inputs;
in
{
  nixpkgs.overlays = [
    (final: prev: 
      rec {
        nv-tmikus = prev.callPackage ./packages/nv-tmikus { };
    })
  ];
}
