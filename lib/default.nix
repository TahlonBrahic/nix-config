{ lib, inputs, ... }@args:
# Credit to EmergentMind 
{
  relativeToRoot = lib.path.append ../.;
  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory")
          || (
            (path != "default.nix") 
            && (lib.strings.hasSuffix ".nix" path) 
          )
        ) (builtins.readDir path)
      )
    );

    systemTemplate = import ./systemTemplate.nix;
    #mergeModules = import ./mergeModules.nix;
    modulesRoot = import ./modulesRoot.nix args;	
    varsRoot = import ./varsRoot.nix args; 
}
