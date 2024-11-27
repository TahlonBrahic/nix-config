{
  inputs,
  lib,
  ...
} @ arguments: let
  inherit (inputs) haumea;

  data = haumea.lib.load {
    src = ./systems;
    inputs = arguments;
  };

  systems = builtins.attrValues data;
  dataWithoutPaths = lib.attrsets.mergeAttrsList (map (it: it.shilo or {}) systems);

  debug = builtins.trace dataWithoutPaths {};

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
  };
in
  outputs // {inherit data;} // debug
