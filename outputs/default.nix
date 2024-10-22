{
  nixpkgs,
  haumea,
  ...
} @ inputs: let
  supportedSystems = ["x86_64-linux" "aarch64-linux"];

  forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  systems = forAllSystems (system: import ./${system} customArgs);

  systemValues = builtins.attrValues systems;

  inherit (nixpkgs) lib;

  customLib = import ../lib {inherit lib haumea;};

  overlayPaths = customLib.overlaysRoot.overlays;

  vars = customLib.varsRoot.varsRoot;

  customArgs = {inherit inputs lib customLib vars;};
in {
  packages = forAllSystems (system: systems.${system}.packages or {});

  overlays = forAllSystems (system: import overlayPaths {inherit inputs system;});

  formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

  devShells = forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in import ../shell.nix {inherit pkgs;});

  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);

  nixOnDroidConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) systemValues);
}
