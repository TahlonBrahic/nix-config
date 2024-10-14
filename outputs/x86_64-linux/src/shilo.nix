{
  inputs,
  customLib,
  vars,
  ...
} @ args: let
  inherit (inputs) sops-nix nix-index-database;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    greetd
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
      inherit args modules;
      vars = outputVars;
    };
  };
}
