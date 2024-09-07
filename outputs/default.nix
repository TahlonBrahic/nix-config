{ self, nixpkgs, home-manager, lib, ... }:

{
  systems = import ./systems;
  systemValues = builtins.attrValues systems;
  nixosConfigurations = lib.attrsets.mergAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
