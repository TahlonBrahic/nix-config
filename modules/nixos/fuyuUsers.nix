{
  config,
  lib,
  pkgs,
  users,
  ...
}: let
  cfg = config.fuyuUsers;
in {
  options = {
    fuyuUsers = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users =
      lib.genAttrs users
      (user: {
        home = "/home/${user}";
        hashedPasswordFile = config.sops.secrets."${user}/hashedPasswordFile".path;
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "${user}"
          "users"
          "networkmanager"
          "wheel"
          "docker"
          "libvirtd"
        ];
        # TODO: map with vars/keys/ssh.nix
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICl40SMOUGnodt39ZLHoLt9trFZfv3rStO+j3bc3tdxf shilo"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0NCg7dOAIc9pRDUb3sOuBluzZHuQkUoYlrQAce/Y89 taistealai"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRUJCFyU2Bhag5GHGq2ihZL6LljX8EZygeKU6KDzHL8 yoru"
        ];
      });
    mutableUsers = false;
  };
}
