{ self, nixpkgs, home-manager, ... }@inputs:

let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.self) self;

  #bin = import ../bin { inherit lib; };
  #vars = import ../vars { inherit lib; };

  customArgs = system: inputs // {
    #inherit bin vars;
  };

  args = { inherit inputs lib self customArgs; };

  systems = builtins.trace "or can we not import" { x86_64-linux = import ./x86_64-linux (args // { system = "x86_64-linux"; }); };
  systemValues = builtins.trace "is this failing" builtins.attrValues systems;

in {
  nixosConfigurations = builtins.trace "outputs" lib.attrsets.mergeAttrsList (map (it: builtins.trace "fuck me" it.nixosConfigurations or {}) systemValues);
  #devShells = {};
}
