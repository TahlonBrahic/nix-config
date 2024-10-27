{
  inputs,
  system,
  pkgs,
}: let
  inherit (inputs.nixpkgs.lib) genAttrs;

  directories = [
    "vars"
    "optionalModules"
    "overlays"
    "functions"
    "baseNixosModules"
    "baseHomeModules"
  ];

  functions = [
    "forEachUser"
    "writeCustomShellApplication"
    "writeCustomWaybarModule"
  ];

  templates = [
    "systemTemplate"
    "droidTemplate"
  ];

  importedDirectories = genAttrs directories (directory: import ./${directory}.nix {inherit inputs system pkgs;});

  #importedFunctions = genAttrs functions (function: import ./${function}.nix);

  importedTemplates = genAttrs templates (template: import ./${template}.nix);

  importedFunctions = { imports = [ ./functions.nix ]; };

  localLib = importedDirectories // importedTemplates // importedFunctions;
in {inherit localLib;}
