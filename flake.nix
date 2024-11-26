{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs.fuyuNoKosei.url = "github:TahlonBrahic/fuyu-no-kosei";

  outputs = inputs: let
    inherit (inputs) fuyuNoKosei;
    inherit (fuyuNoKosei) pkgs forEachSystem genNixosConfig nixosModules homeManagerModules;

    systemConfigurations = forEachSystem (system: import ./outputs/${system} args.${system});
    systemValues = builtins.attrValues systemConfigurations;

    args = forEachSystem (system: rec {
      inherit system;
      inputs = fuyuNoKosei.inputs // {inherit nixosModules homeManagerModules;};
      pkgs = fuyuNoKosei.pkgs.${system};
      lib = fuyuNoKosei.lib.${system};
    });

    debugConfigurations =
      builtins.trace
      (genNixosConfig (map (it: it.nixosConfigurations or {}) systemValues)) {};

    formatter = forEachSystem (system: pkgs.${system}.alejandra);

    devShells = forEachSystem (system: import ./shell.nix {inherit (pkgs.${system}) pkgs;});

    nixosConfigurations = genNixosConfig (map (it: it.nixosConfigurations or {}) systemValues);
  in {
    inherit nixosConfigurations debugConfigurations devShells formatter;
  };
}
