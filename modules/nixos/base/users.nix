{
  users,
  lib,
  localLib,
  pkgs,
  config,
  ...
}: 
let
  forEachUser = localLib.forEachUser {inherit users;};
  configList = forEachUser (map (user: {
    users.mutableUsers = false;

    users.users."${user.username}" = {
      home = "/home/${user.username}";
      inherit (user) initialHashedPassword;
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "${user.username}"
        "users"
        "networkmanager"
        "wheel"
        "docker"
        "libvirtd"
      ];
    };
  
  programs.zsh.enable = true;}) users);

  config = lib.attrsets.mergeAttrsList configList; 
in {
  inherit config;
}
