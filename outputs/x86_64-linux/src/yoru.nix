{
  inputs,
  system, 
  lib,
  localLib,
  pkgs,
  vars,
  overlays
}: let
  #inherit (localLib) optionalModules systemTemplate;
  systemTemplate = localLib.systemTemplate;
  optionalModules = builtins.trace localLib.optionalModules localLib.optionalModules;
  # systemTemplate = lib.debug.traceSeqN 2 localLib {};

  modules = {
    nixos = with optionalModules.nixos; [
      fhs
      greetd
      laptop
    ];

    homeManager = with optionalModules.home; [
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
      style
      waybar
      zellij
      zoxide
    ];
  };

  specialVars = vars.users.tahlon // vars.hardware.yoru;
in {
  nixosConfigurations = {
    "yoru" = systemTemplate {
      inherit inputs system lib localLib pkgs vars overlays modules specialVars;
    };
  };
}
