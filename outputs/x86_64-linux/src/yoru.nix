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
      fhs
      greetd
      laptop
    ];

    tahlon.homeManager = with optionalModules.home; [
      encryption
      fetch
      fish
      fzf
      gpg
      hyprland
      kdeconnect
      kitty
      librewolf
      nvchad
      nix-index
      password
      rofi
      starship
      waybar
      zellij
      zoxide
    ];

    tahlon2.homeManager = with optionalModules.home; [
      zsh
    ];
  };

  users = ["tahlon" "tahlon2"];

  hostName = "yoru";

in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}
