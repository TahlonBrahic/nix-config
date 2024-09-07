{ self, nixpkgs, home-manager }@inputs:
let
  inherit (self) outputs:
  forAllSystems = nixpkgs.lib.genAttrs [
  "x86_64-linux"
  ];
in
{
  systems = import ./systems
  systemValues = builtins.attrValues systems;
  nixosConfigurations = lib.attrsets.mergAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
