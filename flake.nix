{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs = {
    fuyuNoKosei = {
      url = "github:TahlonBrahic/fuyu-no-kosei";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    haumea.url = "github:nix-community/haumea/v0.2.2";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    haumea,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs self;}
    ({
      flake-parts-lib,
      withSystem,
      ...
    }: let
      inherit (flake-parts-lib) importApply;
      lib = inputs.nixpkgs.lib // inputs.fuyuNoKosei.lib;
      flakeModules =
        lib.attrsets.genAttrs ["partitions"] (module:
          importApply ./flake-parts/${module}/flake-module.nix {inherit withSystem;});
    in {
      debug = true;
      systems = ["x86_64-linux"];
      imports =
        [
          flake-parts.flakeModules.flakeModules
          flake-parts.flakeModules.modules
          flake-parts.flakeModules.partitions
        ]
        ++ lib.attrsets.attrValues flakeModules;
      perSystem = {pkgs, ...}: {
        devShells = import ./shell.nix {inherit pkgs;};
      };

      flake = {
        inherit flakeModules;
        nixosConfigurations =
          lib.attrsets.mergeAttrsList
          (lib.lists.forEach (builtins.attrNames
            (haumea.lib.load {
              src = ./flake-parts/systems;
              loader = haumea.lib.loaders.verbatim;
            })) (system:
            haumea.lib.load {
              src = ./flake-parts/systems/${system};
              inputs = {inherit inputs lib;};
            }));
      };
    });
}
