{
  nixpkgs,
  haumea,
  ...
} @ inputs: let

  supportedSystems = ["x86_64-linux" "aarch64-linux"];

  forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  systems = forAllSystems (system: import ./${system} customArgs);

  systemValues = builtins.attrValues systems;

  packages = forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in pkgs );

  pkgs = forAllSystems (system: systems.${system}.packages or {});

  overrides = lib.overlays;

  vars = lib.vars;

  lib = nixpkgs.lib // forAllSystems (system: import ../lib {inherit inputs pkgs;});

  customArgs = forAllSystems (system: let customArgs = { inherit inputs lib vars system; }; in customArgs );

  overlays = forAllSystems (system: import overrides {inherit inputs system;});

  formatter = forAllSystems (system: pkgs.alejandra);

  devShells = forAllSystems (system: import ../shell.nix {inherit pkgs;});

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);

  nixOnDroidConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) systemValues);
in {
  inherit packages overlays formatter devShells nixosConfigurations nixOnDroidConfigurations;
}
