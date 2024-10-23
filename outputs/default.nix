{nixpkgs, haumea, ...} @ inputs: let

  supportedSystems = ["x86_64-linux" "aarch64-linux"];

  forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

  arguments = forAllSystems (system: { 
    inherit inputs system;
    inherit (lib.${system}) pkgs vars overlays
  });
  
  systems = forAllSystems (system: import ./${system} (arguments.${system}));

  systemValues = builtins.attrValues systems;

  local = forAllSystems (system: import ../lib {inherit inputs haumea pkgs system;});

  lib = forAllSystems (system: nixpkgs.lib.attrsets.mergeAttrsList [nixpkgs.lib local.${system}]);

  ##TODO: FIX PACKAGES PKGS

  packages = forAllSystems (system: nixpkgs.legacyPackages.${system} or {});

  pkgs = forAllSystems (system: systems.${system}.packages);

  formatter = forAllSystems (system: pkgs.${system}.alejandra);

  devShells = forAllSystems (system: import ../shell.nix (pkgs.${system});

  nixosConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);

  nixOnDroidConfigurations = nixpkgs.lib.attrsets.mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) systemValues);
in {
  inherit packages formatter devShells nixosConfigurations nixOnDroidConfigurations;
}
