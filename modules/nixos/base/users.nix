{
  users,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.attrsets) genAttrs;
  userlist =
    genAttrs users
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
    });
in {
  users = {
    users = userlist;
    mutableUsers = false;
  };
}
