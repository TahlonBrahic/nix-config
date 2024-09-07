{ ... }:

{
  athena = lib.nixosSystem {
    modules = [
      home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./configuration.nix
  ];  
}
