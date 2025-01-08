{
  inputs,
  self,
  lib,
  ...
}: let
  hostName = "yoru";
  users = ["tahlon"];
  system = "x86_64-linux";
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
  specialArgs = {inherit self inputs hostName system users;};
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules =
      [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "bak";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            # Iterates over a list of users provided in the function call
            users = inputs.nixpkgs.lib.attrsets.genAttrs users (user: {
              imports =
                map (module: inputs.fuyuNoKosei.modules.home.${module})
                (builtins.attrNames
                  inputs.fuyuNoKosei.modules.home);
              config.home.username = user;
            });
          };
        }
      ]
      ++ extraModules
      ++ (map (module: inputs.fuyuNoKosei.modules.nixos.${module})
        (builtins.attrNames
          inputs.fuyuNoKosei.modules.nixos));
  }
