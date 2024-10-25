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
  hostName
}: let
  inherit (inputs) home-manager nur chaotic;
  inherit (localLib) baseNixosModules baseHomeModules;
  specialArgs = {inherit inputs system lib pkgs localLib vars overlays users hostName;};
  extraSpecialArgs = {inherit inputs system lib pkgs localLib vars hostName;};
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
        (map (user:
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            inherit extraSpecialArgs;
            backupFileExtension = "backup_delete";
            users."${user.username}".imports = baseHomeModules ++ modules.homeManager;
          };
        }) users)
      ];
  }
