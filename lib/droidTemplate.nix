{
  customArgs,
  customModules,
  customVars,
}: let
  inherit (customArgs) inputs lib customLib system;
  inherit (inputs) home-manager nix-on-droid;
  vars = customVars;
  specialArgs = extraSpecialArgs // {inherit lib;};
  extraSpecialArgs = {inherit inputs customLib vars;};
  droid = with customLib.nixosModules.opt; [android];
in
 nix-on-droid.lib.nixOnDroidConifguration {
    inherit system specialArgs;
    modules =
      droid
      ++ customModules.nixos
      ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            inherit extraSpecialArgs;
            backupFileExtension = "backup";
            users."${vars.username}".imports = customModules.home;
          };
        }
      ];
  }
