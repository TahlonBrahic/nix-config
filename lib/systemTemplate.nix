{
  inputs,
  system,
  lib,
  localLib,
  pkgs,
  vars,
  overlays,
  modules,
  specialVars,
}: let
  inherit (inputs) home-manager nur chaotic;
  inherit (lib) baseNixosModules baseHomeModules;
  specialArgs = {inherit inputs lib localLib vars specialVars;};
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules =
      baseNixosModules
      ++ [ nur.nixosModules.nur ]
      ++ [ chaotic.nixosModules.default ]
      ++ modules.nixos
      ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            backupFileExtension = "backup_delete";
            users."${specialVars.username}".imports = baseHomeModules ++ modules.homeManager;
          };
        }
      ];
  }
