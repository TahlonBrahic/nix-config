{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) disko sops-nix stylix chaotic nur nix-index-database;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    fhs
    greetd
  ];

  homeModules = with modulesRoot.home.opt; [
    sway
    kitty
    encryption
    gpg
    password
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
    home = homeModules;
  };

  customVars = vars.users.tahlon // vars.hardware.athena;
in {
  nixosConfigurations = {
    "athena" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
