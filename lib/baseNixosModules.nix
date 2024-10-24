{inputs, ...}: let
  inherit (inputs) haumea;
  baseNixosModulesSet = haumea.lib.load {
    src = ../modules/nixos/base;
    loader = haumea.lib.loaders.path;
  };

  baseNixosModules = builtins.attrValues baseNixosModulesSet;
in
  baseNixosModules
