{
  users,
  lib,
  localLib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.attrsets) genAttrs;
  userlist =
    genAttrs users
    (user: {
      home = "/home/${user}";
      initialPassword = "temp";
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
  programs.fish.enable = true;
}
