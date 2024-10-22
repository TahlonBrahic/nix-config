{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (customLib) modulesRoot systemTemplate;

  customModules = {
    nixos = with modulesRoot.nixos.opt; [
      fhs
      greetd
      laptop
    ];

    homeManager = with modulesRoot.home.opt; [
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
