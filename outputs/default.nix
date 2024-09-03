{ inputs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs { inherit system; };
    home-manager = import inputs.home-manager { inherit system; };
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
        home
        modules = [ ../hosts/athena/home.nix ];
      };
    };
  }
