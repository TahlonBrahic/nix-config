{
  inputs,
  lib,
  users,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  config = {
    sops = {
      age = {
        keyFile = "/var/lib/sops-nix/key.txt";
      };
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      secrets = lib.attrsets.mergeAttrsList (builtins.attrValues (lib.genAttrs users (user: {
        "${user}/hashedPasswordFile" = {
          neededForUsers = true;
        };
      })));
    };
  };
}
