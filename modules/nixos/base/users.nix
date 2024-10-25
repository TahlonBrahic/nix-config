{
  users,
  lib,
  localLib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.attrsets) genAttrs;
  test =
    genAttrs users
    (user: {
      home = "/home/${user}";
      initialPassword = "temp";
      isNormalUser = true;
      shell = pkgs.zsh;
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
    users = test;
    mutableUsers = false;
  };

  programs.zsh.enable = true;
}
