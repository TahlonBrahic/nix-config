{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) chaotic sops-nix nvchad4nix nur nix-index-database nixos-wsl;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    wsl
    fhs
  ];

  homeModules = with modulesRoot.home.opt; [
    encryption
    fetch
    zellij
    wsl
  ];

  customModules = {
    nixos =
      [
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
        nixos-wsl.nixosModules.default
        nur.nixosModules.nur
        chaotic.nixosModules.default
      ]
      ++ nixModules;
    home = [nvchad4nix.homeManagerModule] ++ homeModules;
  };

  customVars = vars.users.tbrahic;
in {
  nixosConfigurations = {
    "shilo" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
