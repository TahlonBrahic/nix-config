{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) chaotic sops-nix nvchad4nix nur nix-index-database;
  inherit (customLib) modulesRoot overlaysRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    wsl
    fhs
  ];

  homeModules = with modulesRoot.home.opt; [
    broot
    encryption
    fetch
    fish
    fzf
    lsd
    nvchad
    nix-index
    starship
    zellij
    zoxide
  ];

  customModules = {
    nixos =
      [
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
        nur.nixosModules.nur
        chaotic.nixosModules.default
      ]
      ++ nixModules;
    home = [] ++ homeModules;
  };

  customVars = vars.users.tbrahic;
in {
  nixosConfigurations = {
    "shilo" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
