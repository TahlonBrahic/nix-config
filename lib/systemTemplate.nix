{
  inputs,
  system,
  lib,
  pkgs,
  localLib,
  vars,
  overlays,
  modules,
  users,
  hostName,
}: let
  inherit (inputs) home-manager nur chaotic;
  inherit (localLib) baseNixosModules baseHomeModules;
  specialArgs = {inherit inputs system pkgs localLib vars overlays users hostName;};
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules =
      baseNixosModules
      ++ [nur.nixosModules.nur]
      ++ [chaotic.nixosModules.default]
      ++ modules.nixos
      ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup_delete";
            extraSpecialArgs = specialArgs;
            users =
              lib.attrsets.genAttrs users (
              (user: { imports = (baseHomeModules ++ modules.${user}.homeManager);
              config.${user} = user;}));
          };
        }
      ];
  }
