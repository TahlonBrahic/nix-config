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
  "tahlon" = {
    config = {
      home.username = "tahlon";
      hyprland.enable = true;
    };
  };
  fuyuNoKosei = {
    compositor.hyprland.enable = true;
    services.laptop.enable = true;
    yubikey.enable = true;
  };
in
  lib.systemTemplate {inherit inputs pkgs system hostName users lib overlays;}
