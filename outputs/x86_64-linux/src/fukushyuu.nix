{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos; [
    base.boot
    base.clamav
    base.env
    base.fail2ban
    base.hardware
    base.i18n
    base.network
    base.nftables
    base.nix
    #base.secrets
    base.security
    base.services
    base.sound
    base.users
    base.utils
    base.virt
    #base.yubikey
    base.zram
    base.zsh

    opt.fhs
    #opt.gamemode
    opt.gnome
    opt.steam
  ];

  homeModules = with modulesRoot.home; [
    base.archive
    base.git
    base.xdg
    base.container
    base.nix
    base.home
        
    opt.chrome
    opt.discord
    opt.encryption
    opt.fetch
    opt.gaming
    opt.obsidian
    opt.password
    opt.protonGTK
    opt.streaming
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

  hardwareVars = {
    hostName = "fukushyuu";
    rootUUID = "/dev/disk/by-uuid/f1e944d4-d1d1-4c73-8d52-6ba8cd3fc54a";
    rootFT = "ext4";
    bootUUID = "/dev/disk/by-uuid/4041-F578";
    bootFT = "vfat";
    swapDevices = [ { device = "/dev/disk/by-uuid/56eaaae0-5b35-42dd-8f70-35583866df62";  ];
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
    initrdKernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  outputVars = vars.users.amy // hardwareVars;

in
{
  nixosConfigurations = {
    "${hostName}" = systemTemplate { inherit args modules; vars = outputVars;};
  };
}
