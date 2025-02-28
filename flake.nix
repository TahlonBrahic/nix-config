{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  outputs = {
    flake-utils,
    kosei,
    self,
    ...
  } @ inputs: let
    outPath = ./.;
  in
    flake-utils.lib.eachDefaultSystem (system: {
      devShells = import ./src/dev/shell.nix {inherit kosei system;};
      formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
    })
    // flake-utils.lib.eachDefaultSystemPassThrough (_: {
      nixosConfigurations = kosei.lib.loadConfigurations "scoped" {
        inherit outPath;
        inputs = self.inputs // self.inputs.kosei.inputs;
        src = ./src/systems;
      };
    });

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    kosei.url = "github:TahlonBrahic/fuyu-no-kosei";
    systems.url = "github:nix-systems/x86_64-linux";
  };
}
