{
  inputs,
  sysconfig ? (import <nixpkgs/nixos> {}).config,
  lib,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      show-icons = true;
    };
  };
}
