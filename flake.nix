{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs.fuyuNoKosei.url = "github:TahlonBrahic/fuyu-no-kosei";

  outputs = inputs: let
    inherit (inputs) fuyuNoKosei;
    inherit (fuyuNoKosei) pkgs forEachSystem genNixosConfig nixosModules homeManagerModules;

    systemConfigurations = forEachSystem (system: import ./outputs/${system} args.${system});
    systemValues = builtins.attrValues systemConfigurations;

    args = forEachSystem (system: rec {
      inputs = fuyuNoKosei.inputs // {inherit nixosModules homeManagerModules;};
      inherit system;
      inherit (pkgs.${system}) pkgs;
      lib = fuyuNoKosei.lib.${system};
    });

    formatter = forEachSystem (system: pkgs.${system}.alejandra);

    devShells = forEachSystem (system: import ./shell.nix {inherit (pkgs.${system}) pkgs;});

    nixosConfigurations = genNixosConfig (map (it: it.nixosConfigurations or {}) systemValues);
  in {
    inherit nixosConfigurations devShells formatter;
  };
}
