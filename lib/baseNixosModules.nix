<<<<<<< HEAD
{...} @ args: let
  inherit (args) inputs;
  baseNixosModulesSet = inputs.haumea.lib.load {
||||||| parent of 690d323 (Further debugging)
{args}: let
  inherit (args) inputs;
  baseNixosModulesSet = inputs.haumea.lib.load {
=======
{haumea}: let
  baseNixosModulesSet = haumea.lib.load {
>>>>>>> 690d323 (Further debugging)
    src = ../modules/nixos/base;
    loader = haumea.lib.loaders.path;
  };

  baseNixosModules = builtins.attrValues baseNixosModulesSet;
in
  baseNixosModules
