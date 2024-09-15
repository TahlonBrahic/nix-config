{ ... }@inputs:

let
  _ = builtins.trace "Inputs: ${inputs}" {};
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) self;

  #bin = import ../bin { inherit lib; };
  #vars = import ../vars { inherit lib; };

  customArgs = system: inputs // {
    #inherit bin vars;
  };

  args = { inherit customArgs lib self; };

  systems = { x86_64-linux = import ./x86_64-linux/athena.nix args; };
  systemValues = builtins.attrValues systems;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
