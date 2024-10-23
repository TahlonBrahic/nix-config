{
  inputs,
  lib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (lib) optionalModules systemTemplate;

  customModules = {
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

  customVars = vars.users.tahlon // vars.hardware.yoru;
in {
  nixosConfigurations = {
    "yoru" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
