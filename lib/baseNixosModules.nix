{ ... }@args:

let
  inherit (args) inputs lib customLib vars;
  baseNixosModulesSet = inputs.haumea.lib.load {
    src = ../modules/nixos/base;
    loader = inputs.haumea.lib.loaders.path;
  };

  baseNixosModuleNames = builtins.attrNames baseNixosModulesSet;
  
  fromRoot = "modules/nixos/base";

  baseNixosModules = map (module: fromRoot + module);
   
in
  baseNixosModules    
