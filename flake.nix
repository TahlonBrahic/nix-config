{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs = {
    fuyuNoKosei.url = "github:TahlonBrahic/fuyu-no-kosei";
  };

  outputs = {fuyuNoKosei, ...} @ inputs: let
    inherit (fuyuNoKosei.inputs.nixpkgs) lib;

    forEachSystem = lib.genAttrs fuyuNoKosei.systems;
    systemConfigurations = forEachSystem (system: import ./outputs/${system} args.${system});
    systemValues = builtins.attrValues systemConfigurations;

    args = forEachSystem (system: rec {
      inherit inputs system;
      pkgs = fuyuNoKosei.pkgs.${system};
      lib = fuyuNoKosei.lib.${system};
    });

    pkgs = forEachSystem (system: fuyuNoKosei.pkgs.${system});

    formatter = forEachSystem (system: pkgs.${system}.alejandra);

    devShells = forEachSystem (system: import ./shell.nix {inherit (pkgs.${system}) pkgs;});

    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) systemValues);
  in {
    inherit nixosConfigurations devShells formatter;
  };
}
