{
  inputs,
  system,
  lib,
  ...
} @ args:
  let
  name = "athena";
  system = "x86_64-linux";
  nixpkgs = import nixpkgs {inherit system;};
  base-modules = {
    nixos-modules = [
      # common
      "../../modules/security/default.nix"
      # host specific
      # "hosts/${name}"
    ];
    home-modules = [
      # common
      # "../../"
      # host specific
      # "hosts/${name}/home.nix"
    ];
  };
in {
  nixosConfigurations.${name} = { # This needs to be made into a function
    
      modules = base-modules.nixos-modules
      ++ (
        lib.options ((lib.lists.length base-modules.home-modules) > 0)
        [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            #home-manager.extraSpecialArgs = ;
            home-manager.users.tahlon.imports = home-modules;
          }
        ]
      );
  };
}
