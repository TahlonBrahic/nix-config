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
  fuyuConfig = [
    {
      fuyuNoKosei = {
        compositor.hyprland.enable = true;
        services.laptop.enable = true;
        yubikey.enable = true;
      };

      users."tahlon" = {
        config = {
          hyprland.enable = true;
        };
      };
    }
  ];
in {
  nixosConfigurations =
    lib.systemTemplate
    {inherit inputs pkgs system hostName fuyuConfig users lib overlays;};
}
