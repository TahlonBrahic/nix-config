{
  inputs,
  system,
  pkgs,
}: let
  functions = [
    "writeShellApplicationWrapper"
    "writeWaybarModule"
    "vars"
    "optionalModules"
    "overlays"
    "baseNixosModules"
    "baseHomeModules"
  ];

  templates = [
    "systemTemplate"
    "droidTemplate"
  ];

  importedFunctions = inputs.nixpkgs.lib.genAttrs functions (function:  import ./${function}.nix {inherit inputs system pkgs;});

  importedTemplates = inputs.nixpkgs.lib.genAttrs templates (template: import ./${template}.nix);

  localLib = importedTemplates // importedFunctions;
in { inherit localLib; }
