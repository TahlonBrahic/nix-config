{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) sops-nix nix-index-database nixos-wsl;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    wsl
    fhs
  ];

  homeModules = with modulesRoot.home.opt; [
    encryption
    fetch
    zellij
  ];

  customModules = {
    nixos =
      [
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
        nixos-wsl.nixoModules.default
      ]
      ++ nixModules;
    home = homeModules;
  };

  customVars = args.lib.seqTrace args vars.users.tbrahic;
in {
  nixosConfigurations = {
    "shilo" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
