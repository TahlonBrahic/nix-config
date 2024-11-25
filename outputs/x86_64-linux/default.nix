{
  inputs,
  lib,
  ...
} @ arguments: let
  inherit (inputs) haumea;

  data = haumea.lib.load {
    src = ./systems/yoru;
    inputs = arguments;
  };

  dataWithoutPaths = builtins.attrValues data;

  mergedSystems = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);

  outputs = {
    nixosConfigurations = builtins.trace mergedSystems mergedSystems;
  };
in
  outputs // {inherit data;}
