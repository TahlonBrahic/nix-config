{
  inputs,
  system,
  lib,
  localLib,
  pkgs,
  pkgs-stable,
  vars,
  overlays,
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
      firefox
      fish
      fzf
      gpg
      hyprland
      jeezyvim
      kdeconnect
      kitty
      librewolf
      nix-index
      password
      rofi
      starship
      waybar
      zellij
      zoxide
    ];
  };

  users = ["tahlon"];

  hostName = "yoru";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs pkgs-stable localLib vars overlays modules users hostName;
    };
  };
}
