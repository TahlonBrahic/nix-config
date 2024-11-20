{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs.url = "github:TahlonBrahic/fuyu-no-kosei";

  outputs = {inputs}: let
    inherit (inputs) nixpkgs systems pkgs lib;

    forEachSystem = nixpkgs.lib.genAttrs systems;
    systemConfigurations = forEachSystem (system: import ./outputs/${system} args.${system});
    systemValues = builtins.attrValues systemConfigurations;

    args = forEachSystem (system: rec {
      inherit inputs system;
      inherit (pkgs.${system}) pkgs;
      inherit (lib.${system}) lib;
    });

    formatter = forEachSystem (system: pkgs.${system}.alejandra);

    devShells = forEachSystem (system: import ./shell.nix {inherit (pkgs.${system}) pkgs;});

    nixosConfigurations =
      nixpkgs.lib.attrsets.mergeAttrsList
      (map (it: it.nixosConfigurations or {}) systemValues);
  in {
    inherit nixosConfigurations devShells formatter;
  };
}
