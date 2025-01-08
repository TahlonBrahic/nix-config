{
  inputs,
  lib,
  ...
}: let
  hostName = "athena";
  users = ["tahlon" "test"];
  system = "x86_64-linux";
  modules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in
  lib.systemTemplate
  {
    inherit inputs hostName lib modules system users;
  }
