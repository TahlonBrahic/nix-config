{
  inputs,
  customLib,
  vars,
  ...
} @ args: let
  inherit (inputs) disko sops-nix impermanence stylix chaotic;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    fhs
    greetd
    style
  ];

  homeModules = with modulesRoot.home.opt; [
    encryption
    fetch
    hyprland
    kitty
    librewolf
    password
    rofi
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
        chaotic.nixosModules.default
      ]
      ++ nixModules;
    home = homeModules;
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
