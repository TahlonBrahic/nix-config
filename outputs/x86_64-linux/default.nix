{ lib, ... }@args:

let
  configurations = builtins.readDir ./src;
  data = builtins.listToAttrs 
    (map (fileName: {
    name = fileName;
    value = import ./src + "/${fileName}" args;})
    (builtins.attrNames configurations));
  dataWithoutPaths = builtins.attrValues data;
in {
  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
    packages = lib.attrsets.mergeAttrsList (map (it: it.packages or {}) dataWithoutPaths);
  };
}  
