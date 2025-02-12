inputs: let
  inherit (inputs) kosei nixpkgs flake-utils;
  inherit (nixpkgs) lib;
  outPath = ./.;
in
  flake-utils.lib.eachDefaultSystemPassThrough (system: let
    pkgs =
      import nixpkgs
      {
        inherit system;
        config.allowUnfree = true;
      };
  in {
    nixosConfigurations = kosei.lib.loadConfigurations "scoped" {
      inherit inputs lib pkgs outPath;
      src = ./src/systems;
    };

    devShells.${system} = import ./src/dev/shell.nix {inherit pkgs;};
  })
