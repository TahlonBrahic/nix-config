{
  nixpkgs,
  haumea,
  ...
} @ inputs: let
  supportedSystems = ["x86_64-linux" "aarch64-linux"];

  forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  systems = forAllSystems (system: let
    lib = let
      localLib = import ../lib {inherit inputs haumea pkgs;};
      nixpkgsLib = nixpkgs.lib;
    in {lib = localLib // nixpkgs;};
    vars = lib.vars;
    customArgs = {
      inherit inputs vars system lib;
    };
  in
    import ./${system} customArgs);

  systemValues = builtins.attrValues systems;

  packages = forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in pkgs);

  pkgs = forAllSystems (system: systems.${system}.packages or {});

  #overlays = forAllSystems (system: import overrides {inherit inputs system;});

  formatter = forAllSystems (system: pkgs.alejandra);

  devShells = forAllSystems (system: import ../shell.nix {inherit pkgs;});

  nixosConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);

  nixOnDroidConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) systemValues);
in {
  inherit packages formatter devShells nixosConfigurations nixOnDroidConfigurations;
}
