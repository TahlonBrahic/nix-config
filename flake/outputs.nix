inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;}
{
  flake = let
    outPath = ./.;
  in {
    nixosConfigurations = inputs.kosei.lib.loadConfigurations "scoped" {
      inherit inputs outPath;
      src = ./systems;
    };
  };

  systems = [
    "x86_64-linux"
  ];

  perSystem = {pkgs, ...}: {
    devShells = import ./src/dev/shell.nix {inherit pkgs;};
    formatter = pkgs.alejandra;
  };
}
