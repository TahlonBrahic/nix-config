{args}: let
  inherit (args) inputs;
  baseNixosModulesSet = inputs.haumea.lib.load {
    src = ../modules/nixos/base;
    loader = inputs.haumea.lib.loaders.path;
  };

  baseNixosModules = builtins.attrValues baseNixosModulesSet;
in
  baseNixosModules
