{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs = {
    fuyuNoKosei.url = "github:TahlonBrahic/fuyu-no-kosei";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs self;}
    ({flake-parts-lib, ...}: let
      inherit (inputs.fuyuNoKosei) nixosModules homeManagerModules;
      inherit (flake-parts-lib) importApply;
      inherit (nixpkgs) lib;
      flakeModules.default = importApply ./flake-parts/options/args.nix {localFlake = self.flake;};
    in {
      debug = true;
      systems = ["x86_64-linux"];
      imports = [flakeModules.default];
      perSystem = {
        system,
        inputs',
        ...
      }: {
        args = {
          inherit system;
          inherit (self.inputs.fuyuNoKosei.pkgs.${system}) pkgs;
          lib = self.inputs.fuyuNoKosei.lib.${system};
          inputs = self.inputs.fuyuNoKosei.inputs // {inherit nixosModules homeManagerModules;};
        };

        checks = let
          inherit (inputs.fuyuNoKosei.inputs) pre-commit-hooks;
        in
          import ./checks/pre-commit.nix {inherit pre-commit-hooks system;};

        # devShells = import ./shell.nix {inherit (inputs'.nixpkgs.legacyPackages) pkgs;};
        # formatter = withSystem system nixpkgs.legacyPackages.${system}.alejandra;
      };
      flake = {
        nixosConfigurations =
          lib.pipe
          ["x86_64-linux"]
          [
            (map (system: import ./outputs/${system} self.args.${system}))
            (map (system: builtins.getAttr "nixosConfigurations" system))
            lib.attrsets.mergeAttrsList
          ];
      };
    });
}
