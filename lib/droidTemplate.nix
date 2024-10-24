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
  inherit (inputs) home-manager nix-on-droid nur chaotic;
  inherit (localLib) baseNixosModules baseHomeModules; 
  specialArgs = {inherit inputs lib localLib vars specialVars;};
  droid = with localLib.optionalModules.opt; [android];
in
 nix-on-droid.lib.nixOnDroidConifguration {
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
