{
  inputs,
  systems,
  lib,
  ...
} @ arguments: let
  inherit (inputs) haumea nix-on-droid flake-utils;
  inherit (lib.attrsets) mergeAttrsList;


  dataSet = flake-utils.lib.eachDefaultSystem (haumea.lib.load {
    src = ./${system};
    inputs = arguments // {inherit ${system};};
  });

  data = builtins.attrValues dataSet;

  outputs = {
    nixOnDroidConfigurations = mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) data);
    nixosConfigurations = mergeAttrsList (map (it: it.nixosConfigurations or {}) data);
  };
in
  outputs // {inherit data;}
