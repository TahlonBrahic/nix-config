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
  extraSpecialArgs = {inherit inputs system pkgs localLib vars overlays hostName;};
  mappedArgs = lib.attrsets.genAttrs users (user: {inherit inputs pkgs vars lib user;});
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
            inherit extraSpecialArgs;
            users =
              lib.attrsets.genAttrs users
              (user: {
                imports = modules.homeManager ++
                # If this does not work I need to do some weird magic where I take the list of paths (baseHomeModules)
                # then import each one of them with mappedArgs.${user}, I am not sure what dataset this created backup_delete
                # I may need to devise a way to write to the nix store then return its aggregation as a path to append to 
                # the imports list.
                (map (module:
                  import module mappedArgs.${user})
                baseHomeModules);});
          };
        }
      ];
  }
