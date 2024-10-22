{
  customArgs,
  customModules,
  customVars,
}: let
  inherit (customArgs) inputs lib customLib system vars;
  inherit (inputs) home-manager;
  inherit (customLib) baseNixosModules baseHomeModules;
  specialArgs = extraSpecialArgs // {inherit lib;};
  extraSpecialArgs = {inherit inputs customLib vars customVars;};
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules =
      baseNixosModules
      ++ customModules.nixos
      ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            inherit extraSpecialArgs;
            backupFileExtension = "backup";
            users."${customVars.username}".imports = baseHomeModules ++ customModules.home;
          };
        }
      ];
  }
