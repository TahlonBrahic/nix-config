{ lib, inputs, ... }@args:

let
  configurations = builtins.trace "configurations" builtins.readDir ./src;
  data = builtins.trace "data" builtins.listToAttrs 
    (map (fileName: {
    name = fileName;
    value = builtins.trace "Importing ${fileName}" import ./src + "/${fileName}" args;})
    (builtins.attrNames configurations));
  dataWithoutPaths = builtins.trace "datawithoutpaths" builtins.attrValues data;
in {
    nixosConfigurations = builtins.trace "linux 1" lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
    packages = builtins.trace "linux 2" lib.attrsets.mergeAttrsList (map (it: it.packages or {}) dataWithoutPaths);
}  
