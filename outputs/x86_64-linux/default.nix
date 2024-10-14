<<<<<<< HEAD
{lib, ...} @ customArgs: let
  inherit (customArgs.inputs) haumea;
||||||| parent of 690d323 (Further debugging)
{ lib, ... }@customArgs:

let
  inherit (customArgs.inputs) haumea;
=======
{ lib, 
  inputs,
  ...
}@customArgs:
let
  inherit (inputs) haumea;
>>>>>>> 690d323 (Further debugging)

  data = haumea.lib.load {
    src = ./src;
    inputs = customArgs // {system = "x86_64-linux";};
  };

  dataWithoutPaths = builtins.attrValues data;

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
  };
in
  outputs // {inherit data;}
