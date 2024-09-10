{ lib, ... }@inputs:

let
  configurations = builtins.readDir ./src;

  data = builtins.listToAttrs (map (fileName: {
    name = fileName;
    value = builtins.trace ("Importing file: ${fileName}") (import (./src + "/${fileName}") { inherit lib; });
  }) (builtins.attrNames configurations));

  dataWithoutPaths = builtins.attrValues data;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
}
