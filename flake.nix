{
  description = "NixOS configuration that follows fuyu-no-kosei.";
  outputs = inputs @ {
    flake-parts,
    kosei,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;}
    ({self, ...}: {
      debug = true;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        flake-parts.flakeModules.modules
        flake-parts.flakeModules.partitions
      ];

      partitions = {
        dev = {
          module = ./src/dev;
          extraInputsFlake = ./src/dev;
        };
      };

      partitionedAttrs = {
        checks = "dev";
        devShells = "dev";
        herculesCI = "dev";
      };

      perSystem = {system, ...}: {
        formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
      };

      flake = {
        nixosConfigurations = kosei.lib.loadConfigurations "scoped" {
          inherit (self) outPath;
          inputs = self.inputs // self.inputs.kosei.inputs;
          src = ./src/systems;
        };
      };
    });

  inputs = {
    kosei.url = "github:TahlonBrahic/fuyu-no-kosei";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
