{ self, nixpkgs, home-manager, ... }@inputs:

let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) self;
  systems = import ./systems { inherit inputs lib self; };
  systemValues = builtins.attrValues systems;
in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
