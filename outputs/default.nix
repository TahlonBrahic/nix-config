{ ... }@inputs:

let
  inherit (inputs.nixpkgs) lib;

  bin = import ../bin { inherit lib; };
  vars = import ../vars { inherit lib; };

  customArgs = system: inputs 
     // { inherit bin vars; };

  args = { inherit inputs lib customArgs; };

  systems = {
    x86_64-linux = import ./x86_64-linux args;
  };

  systemValues = builtins.attrValues systems;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
