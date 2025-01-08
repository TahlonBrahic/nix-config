{
  inputs,
  lib,
  ...
}: let
  hostName = "fukushyuu";
  users = ["amy"];
  system = "x86_64-linux";
  modules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in {
  inherit inputs hostName lib modules system users;
}
