{ self, nixpkgs, home-manager, lib, ... }@inputs:

{
  systems = import ./systems { inherit inputs; };
  systemValues = builtins.attrValues systems;
  nixosConfigurations = lib.attrsets.mergAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
