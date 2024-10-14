{
  inputs,
  customLib,
  vars,
  ...
} @ args: let
  inherit (inputs) disko sops-nix impermanence stylix;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    greetd
    fhs
    greetd
  ];

  homeModules = with modulesRoot.home; [
    librewolf
    encryption
    fetch
    hyprland
    kitty
    password
    waybar
    zellij
  ];

  modules = {
    nixos =
      [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        impermanence.nixosModules.impermanence
      ]
      ++ nixModules;
    home =
      [
      ]
      ++ homeModules;
  };

  outputVars = vars.users.tahlon // vars.hardware.yoru;
in {
  nixosConfigurations = {
    "yoru" = systemTemplate {
      inherit args modules;
      vars = outputVars;
    };
  };
}
