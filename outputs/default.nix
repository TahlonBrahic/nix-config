{ ... }@inputs:

let
  _ = builtins.trace "Inputs: ${inputs}" {};
  inherit (inputs.home-manager) home-manager;
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) self;

  #bin = import ../bin { inherit lib; };
  #vars = import ../vars { inherit lib; };

#  customArgs = system: inputs # be sure to add customArgs to args below
#     // { inherit bin vars; };

  args = { inherit inputs home-manager lib self; };

  systems = { x86_64-linux = import ./x86_64-linux/athena.nix args; };
  systemValues = builtins.attrValues systems;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
