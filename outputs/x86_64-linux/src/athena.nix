{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos [
    opt.greetd
    opt.fhs
  ];

  homeModules = with modulesRoot.home; [
    opt.obsidian
    opt.sway
    opt.kitty
    opt.encryption
    opt.gpg
    opt.password
    opt.zellij
  ];

  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
    ] ++ nixModules;
    home = [
    ] ++ homeModules;
  };

  
  # Hardware Variables
  hardwareVars = {
    hostName = "nani";
    rootUUID = "/dev/disk/by-uuid/bfbb2b4f-d7d4-4a26-bfa2-55148077754d";
    rootFT = "ext4";
    bootUUID = "/dev/disk/by-uuid/80D3-F09A";
    bootFT = "vfat";
    swapDevices = [  ];
    imports =  [ (modulesPath + "/profiles/qemu-guest.nix") ];
    initrdKernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm_intel" ];
    extraModulePackages = [ ];
  };

  outputVars = vars.users.tahlon // hardwareVars;

in
{
  nixosConfigurations = {
    "${hostName}" = systemTemplate { inherit args modules; vars = outputVars; };
  };
}
