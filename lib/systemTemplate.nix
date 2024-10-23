{
  customArgs,
  customModules,
  customVars,
}: let
  inherit (customArgs) inputs lib system vars;
  inherit (inputs) home-manager nur chaotic;
  inherit (lib) baseNixosModules baseHomeModules;
  specialArgs = {inherit inputs lib vars customVars;};
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules =
      baseNixosModules
      ++ nur.nixosModules.nur
      ++ chaotic.nixosModules.default
      ++ customModules.nixos
      ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            backupFileExtension = "backup_delete";
            users."${customVars.username}".imports = baseHomeModules ++ customModules.homeManager;
          };
        }
      ];
  }
