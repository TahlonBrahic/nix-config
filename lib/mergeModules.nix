{ lib, bin, modules, ... }:

let
  # Modules are imported as a list of paths (strings)
  # relativeModules returns a list of paths relative to project root (strings)
  relativeModules = map (module: bin.relativeToRoot module) modules;

  # parsedModules takes the list of strings and extracts their attribute set
  parsedModules = map (relativeModule: import relativeModule) relativeModules;  

  # mergedAttrs then takes the list of attribute sets and merges it into one set
  mergedAttrs = lib.attrsets.mergeAttrsList parsedModules;
in
  mergedAttrs
