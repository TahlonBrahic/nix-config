{ ... }@args:

let
  inherit (args) inputs lib customLib vars;
  baseHomeModulesSet = inputs.haumea.lib.load {
    src = ../modules/home/base;
    loader = inputs.haumea.lib.loaders.path;
  };

  baseHomeModules = builtins.attrValues baseHomeModulesSet;
 
in
  baseHomeModules  
