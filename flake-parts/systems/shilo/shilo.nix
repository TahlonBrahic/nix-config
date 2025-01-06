{
  inputs,
  lib,
  ...
}: let
  hostName = "shilo";
  users = ["tbrahic"];
  system = "x86_64-linux";
  modules = [
    ./_home.nix
    ./_configuration.nix
  ];
in
  lib.systemTemplate
  {
    inherit inputs hostName lib modules system users;
  }
