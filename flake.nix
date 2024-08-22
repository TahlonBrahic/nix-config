{
  description = "nixos by tahlon"
  
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    home-manager.url = github:nix-community/home-manager;
  };

  outputs = { self, nixpkgs, home-manager }: {
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        tahlon-desktop = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./hosts/tahlon-desktop.nix
            ./home-manager/default.nix
          ];
        };   
      };
    };
  };
}
