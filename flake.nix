{
.  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  inputs.home-manager.url = github:nix-community/home-manager;

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.athena = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./hosts/configuration.nix ];
    };
  };
}
