{
  inputs,
  pkgs,
  system,
  lib,
  overlays,
  ...
}: let
  hostName = "yoru";
  users = ["tahlon"];
in
  lib.systemTemplate {inherit inputs pkgs system hostName users lib overlays;}
