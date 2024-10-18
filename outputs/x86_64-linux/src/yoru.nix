{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) disko sops-nix stylix chaotic nvchad4nix nur nix-index-database;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    fhs
    greetd
    laptop
    style
  ];

  homeModules = with modulesRoot.home.opt; [
    encryption
    fetch
    hyprland
    kitty
    librewolf
    nvchad
    password
    rofi
    waybar
    zellij
  ];

  customModules = {
    nixos =
      [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        chaotic.nixosModules.default
        nur.nixosModules.nur
        nix-index-database.nixosModules.nix-index
      ]
      ++ nixModules;
    home = [
      ]
      ++ homeModules;
  };

  customVars = vars.users.tahlon // vars.hardware.yoru;
in {
  nixosConfigurations = {
    "yoru" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
