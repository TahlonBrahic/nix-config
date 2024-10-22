{
  nixpkgs,
  haumea,
  ...
} @ inputs: let
  lib = nixpkgs.lib // import ../lib {inherit lib haumea;};

  supportedSystems = ["x86_64-linux" "aarch64-linux"];

  forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  systems = forAllSystems (system: import ./${system} customArgs);

  systemValues = builtins.attrValues systems;

  overrides = lib.overlays;

  vars = lib.vars;

  customArgs = {inherit inputs lib vars;};
in {
  packages = forAllSystems (system: systems.${system}.packages or {});

  overlays = forAllSystems (system: import overrides {inherit inputs system;});

  formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

  devShells = forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in import ../shell.nix {inherit pkgs;});

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);

  nixOnDroidConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) systemValues);
}
