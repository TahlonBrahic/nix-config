{ lib, bin, modules, ... }:

let
  relativeModulest = map (module: bin.relativeToRoot module) modules;
  relativeModules = builtins.trace relativeModulest relativeModulest;
  mergedAttrs = lib.attrsets.mergeAttrsList relativeModules;
in
  mergedAttrs
