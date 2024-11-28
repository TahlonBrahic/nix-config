{
  inputs,
  lib,
  ...
} @ arguments: let
  data = inputs.haumea.lib.load {
    src = ./systems;
    inputs = arguments;
  };

  systems = lib.attrsets.mergeAttrsList (map (it: it) (builtins.attrValues data)); # { yoru = {...} shilo = {...} }
  systemConfigurations = builtins.attrValues systems; # [ { nixosConfigurations  = ...} { nixosConfigurations = ...} ]

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations) systemConfigurations);
  };
in
  outputs // {inherit data;}
