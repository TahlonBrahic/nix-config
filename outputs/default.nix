{nixpkgs, haumea, ...}@inputs: let

  inherit (nixpkgs) lib;

<<<<<<< HEAD
  customLib = import ../lib {inherit lib;};
||||||| parent of 690d323 (Further debugging)
  # Import library of custom functions used in this flake
  customLib = import ../lib {inherit inputs lib vars;};
=======
  # Import library of custom functions used in this flake
  customLib = import ../lib {inherit lib; inherit (inputs) haumea;};
>>>>>>> 690d323 (Further debugging)

  vars = customLib.varsRoot.varsRoot;

  customArgs = {inherit inputs lib customLib vars;};

  systems = {
    x86_64-linux = import ./x86_64-linux customArgs;
  };

  systemValues = builtins.attrValues systems;
in {
  formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64.alejandra;

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
