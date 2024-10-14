{
  inputs,
  customLib,
  vars,
  ...
} @ args: let
  inherit (inputs) disko sops-nix;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    fhs
    gnome
    steam
  ];

  homeModules = with modulesRoot.home.opt; [
    chrome
    discord
    encryption
    fetch
    gaming
    obsidian
    password
    protonGTK
    streaming
    zellij
  ];

  modules = {
    nixos =
      [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
      ]
      ++ nixModules;
    home = homeModules;
  };

  outputVars = vars.users.amy // vars.hardware.fukushyuu;
in {
  nixosConfigurations = {
    "fukushyuu" = systemTemplate {
      inherit args modules;
      vars = outputVars;
    };
  };
}
