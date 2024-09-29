{ config, pkgs, lib, ...}:

{
  imports = [
    ./i3.nix
    ./sway.nix
    ./gnome.nix
    ./hyprland.nix
  ];
}
