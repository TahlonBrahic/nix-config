{inputs, ...}: let
  inherit (inputs) haumea;
  overlays = haumea.lib.load {
    src = ../overlays;
    loader = haumea.lib.loaders.path;
  };
in
  overlays
