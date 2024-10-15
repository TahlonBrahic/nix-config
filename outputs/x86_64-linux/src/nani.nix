{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) disko sops-nix stylix;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    greetd
    fhs
    style
  ];

  homeModules = with modulesRoot.home.opt; [
    librewolf
    encryption
    fetch
    kitty
    password
    sway
    waybar
    zellij
  ];

  customModules = {
    nixos =
      [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
      ]
      ++ nixModules;
    home = homeModules;
  };
  customVars = vars.users.tahlon // vars.hardware.nani;
in {
  nixosConfigurations = {
    "nani" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
