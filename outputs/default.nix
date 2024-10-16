{
  nixpkgs,
  haumea,
  ...
} @ inputs: let

  forAllSystems = nixpkgs.lib.genAttrs [
    "x86_64-linux"
    "aarch64-linux"
  ];

  inherit (nixpkgs) lib;

  customLib = import ../lib {inherit lib haumea;};

  vars = customLib.varsRoot.varsRoot;

  customArgs = {inherit inputs lib customLib vars;};

  systems = {
    x86_64-linux = import ./x86_64-linux customArgs;
  };

  systemValues = builtins.attrValues systems;
in {
  formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
