{inputs}: let
  inherit (inputs) fuyuNoKosei;

  # Supported system architectures
  systems = ["x86_64-linux" "aarch64-linux" "riscv64-linux"];

  # perSystem function to handle system-specific configurations
  perSystem = {system, ...}: let
    # pkgs and lib are handled by fuyuNoKosei
    pkgs = fuyuNoKosei.pkgs.${system};
    lib = fuyuNoKosei.lib.${system};
    formatter = pkgs.${system}.alejandra;
    devShells = import ../shell.nix {inherit pkgs;};
    nixosConfigurations = import ../${system} {inherit inputs system pkgs lib;};
  in {
    inherit pkgs lib formatter devShells nixosConfigurations;
  };

  # Generate the system-specific outputs using perSystem
  systemOutputs = builtins.map (system: perSystem {inherit system inputs;}) systems;

  # Extract the outputs from systemOutputs
  nixosConfigurations = builtins.map (o: o.nixosConfigurations) systemOutputs;
  devShells = builtins.map (o: o.devShells) systemOutputs;
in {
  inherit nixosConfigurations devShells;
}
