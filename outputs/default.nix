{ ... }@inputs:

let
  # Extract important utility functions from Nixpkgs e.g. mkIf, concatMap, ...
  inherit (inputs.nixpkgs) lib;

  # Import library of custom functions used in this flake
  customLib = import ../lib { inherit inputs lib vars; };

  # Import variables such as users
  vars = customLib.varsRoot.varsRoot;

  # Wrap these together into an custom attribute set
  customArgs = { inherit inputs lib customLib vars; };

  systems = {
    x86_64-linux = import ./x86_64-linux customArgs;
    # aarch64-darwin = import ./aarch64-darwin customArgs;
  };

  systemValues = builtins.attrValues systems;

in {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
