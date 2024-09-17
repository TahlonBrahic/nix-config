{ ... }@inputs:

let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) self;

  #bin = import ../bin { inherit lib; };
  #vars = import ../vars { inherit lib; };

#  customArgs = system: inputs # be sure to add customArgs to args below
#     // { inherit bin vars; };

  args = { inherit inputs lib self; };

  systemPaths = {
    x86_64 = builtins.attrNames (builtins.readDir ./x86_64-linux);
  };

  systemValues = builtins.attrValues systemPaths;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
