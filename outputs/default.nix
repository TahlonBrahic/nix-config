{ nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    homeConfigurations = {
      tahlon = home-manager.lib.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ../home/hosts/athena/home.nix ];
      };
    };
  }
