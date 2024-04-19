{ flake, system, lib, ... }:

let
  inherit (flake) inputs;
in
{
  nixpkgs.overlays = [
    (final: prev: 
      rec {
        nvchad = prev.callPackage ./packages/nvchad { };
    })
  ];
}
