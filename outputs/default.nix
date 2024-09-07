{ self, nixpkgs, home-manager, lib, ... }@inputs:

let
  inherit inputs;
  systems = import ./systems { inherit inputs; };
  systemValues = builtins.attrValues systems;
in
{
  nixosConfigurations = lib.attrsets.mergAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
