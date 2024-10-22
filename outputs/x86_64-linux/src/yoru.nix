{
  inputs,
  lib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (lib) modules systemTemplate;

  customModules = {
    nixos = with modules.nixos.opt; [
      fhs
      greetd
      laptop
    ];

    homeManager = with modules.home.opt; [
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
