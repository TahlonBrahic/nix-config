{
  customArgs,
  customModules,
  customVars,
}: let
  inherit (customArgs) inputs lib customLib system vars;
  inherit (inputs) home-manager nur chaotic;
  inherit (customLib) baseNixosModules baseHomeModules;
  specialArgs = extraSpecialArgs // {inherit lib;};
  extraSpecialArgs = {inherit inputs customLib vars customVars;};
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
            inherit extraSpecialArgs;
            backupFileExtension = "backup";
            users."${customVars.username}".imports = baseHomeModules ++ customModules.homeManager;
          };
        }
      ];
  }
