{
  inputs,
  system, 
  lib,
  localLib,
  pkgs,
  vars,
  overlays
}: let
  inherit (localLib) optionalModules systemTemplate;

  modules = {
    nixos = with optionalModules.nixos; [
      wsl
    ];

    homeManager = with optionalModules.home; [
      broot
      encryption
      fetch
      firefox
      fish
      fzf
      lsd
      nvchad
      nix-index
      starship
      zellij
      zoxide
    ];
  };

  users = ["tbrahic"];

  hostName = "shilo";

in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}
