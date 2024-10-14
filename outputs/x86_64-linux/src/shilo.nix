{
  inputs,
  customLib,
  vars,
  ...
} @ customArgs: let
  inherit (inputs) sops-nix nix-index-database;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    wsl
  ];

  homeModules = with modulesRoot.home.opt; [
    encryption
    fetch
    zellij
  ];

  modules = {
    nixos =
      [
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
      ]
      ++ nixModules;
    home = homeModules;
  };

  outputVars = vars.users.tbrahic;
in {
  nixosConfigurations = {
    "shilo" = systemTemplate {
      args = customArgs;
      inherit modules;
      vars = outputVars;
    };
  };
}
