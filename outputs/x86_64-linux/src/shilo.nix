{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) chaotic sops-nix nur;
  inherit (customLib) modulesRoot overlaysRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    wsl
  ];

  homeModules = with modulesRoot.home.opt; [
    broot
    encryption
    fetch
    firefox
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
