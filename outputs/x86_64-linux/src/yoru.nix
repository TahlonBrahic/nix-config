{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix impermanence stylix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    greetd
    fhs
  ];

  homeModules = with modulesRoot.home.opt; [
    librewolf
    encryption
    fetch
    hyprland
    kitty
    password
    rofi
    waybar
    zellij
  ];

  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
      stylix.nixosModules.stylix
      impermanence.nixosModules.impermanence
    ] ++ nixModules;
    home = [
    ] ++ homeModules;
  };

  outputVars = vars.users.tahlon // vars.hardware.yoru;

in
{
  nixosConfigurations = {
    "yoru" = systemTemplate { inherit args modules; vars = outputVars; };
  };
}
