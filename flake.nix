{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs.fuyuNoKosei.url = "github:TahlonBrahic/fuyu-no-kosei";

  outputs = inputs @ {
    fuyuNoKosei,
    self,
    ...
  }: let
    inherit (fuyuNoKosei) systems pkgs forEachSystem genConfig nixosModules homeManagerModules;
    inherit (fuyuNoKosei.inputs) flake-parts;
    systemConfigurations = forEachSystem (system: import ./outputs/${system} args.${system});
    systemValues = builtins.attrValues systemConfigurations;

    args = forEachSystem (system: rec {
      inherit system;
      inputs = fuyuNoKosei.inputs // {inherit nixosModules homeManagerModules;};
      pkgs = fuyuNoKosei.pkgs.${system};
      lib = fuyuNoKosei.lib.${system};
    });
  in
    flake-parts.lib.mkFlake {inherit inputs self;} {
      inherit systems;
      perSystem = {system, ...}: {
        formatter = fuyuNoKosei.pkgs.${system}.alejandra;
        devShells = import ./shell.nix {inherit (pkgs.${system}) pkgs;};
      };
      flake = {
        debug = true;
        nixosConfigurations = genConfig (map (it: it.nixosConfigurations or {}) systemValues);
        nixOnDroidConfigurations = genConfig (map (it: (it.nixosConfigurations or {}) systemValues));
        inherit forEachSystem;
      };
    };
}
