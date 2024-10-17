{
  nixpkgs,
  haumea,
  ...
} @inputs: let

  # Generate an attribute set by mapping a function over a list of attribute names.
  # genAttrs [ "foo" "bar" ] (name: "x_" + name) => { foo = "x_foo"; bar = "x_bar"; }
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
  formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64.alejandra;

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
}
