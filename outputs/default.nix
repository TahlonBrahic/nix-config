{ ... }@inputs:

let
  inherit (inputs.nixpkgs) lib;

  #bin = import ../bin { inherit lib; };
  #vars = import ../vars { inherit lib; };

#  customArgs = system: inputs # be sure to add customArgs to args below
#     // { inherit bin vars; };

  args = { inherit inputs lib; };

  systems = {
    x86_64-linux = import ./x86_64-linux args;
  };

  systemValues = builtins.attrValues systems;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
