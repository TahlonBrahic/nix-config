{nixpkgs, haumea, ...}@inputs: let

  inherit (nixpkgs) lib;

  customLib = import ../lib {inherit lib; inherit (inputs) haumea;};

  vars = customLib.varsRoot.varsRoot;

  customArgs = {inherit inputs lib customLib vars;};

  systems = {
    x86_64-linux = import ./x86_64-linux customArgs;
  };

  systemValues = builtins.attrValues systems;
in {
  formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64.alejandra;

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
