{inputs}: let
  # Rebind `inputs` to `inputs.fuyuNoKosei` as all inputs are handled by fuyuNoKosei
  inherit inputs;

  # perSystem function to handle system-specific configurations
  perSystem = {system, ...}: let
    pkgs = inputs.pkgs.${system};
    lib = inputs.lib.${system};
    formatter = pkgs.${system}.alejandra;
    devShells = import ../shell.nix {inherit pkgs;};
    nixosConfigurations = import ../${system} {inherit inputs system pkgs lib;};
  in {
    inherit pkgs lib formatter devShells nixosConfigurations;
  };

  # Generate system-specific outputs using perSystem
  systemOutputs = builtins.map (system: perSystem {inherit system inputs;}) inputs.systems;

  # Extract the outputs from systemOutputs
  nixosConfigurations = builtins.map (o: o.nixosConfigurations) systemOutputs;
  devShells = builtins.map (o: o.devShells) systemOutputs;
in {
  inherit nixosConfigurations devShells;
}
