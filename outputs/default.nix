{ inputs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      athena = nixpkgs.lib.nixosSystem {
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
