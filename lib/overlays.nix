{inputs, system, pkgs}: let
  inherit (inputs) haumea;
  overlays = haumea.lib.load {
    src = ../overlays;
    inputs = {inherit inputs system pkgs;};
  };
  overlayss = builtins.attrValues overlays;
in
  overlayss
