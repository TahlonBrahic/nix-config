{ inputs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      athena = pkgs.lib.nixosSystem {
        inherit system;
        modules = [ ../hosts/athena/default.nix ];
      };
    };
    homeConfigurations = {
      tahlon = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ../home/hosts/athena/home.nix ];
      };
    };
  }
