{
  pkgs ? import <nixpkgs> {},
  users,
}: let
  forEachUser = pkgs.lib.genAttrs users;
in
  forEachUser
