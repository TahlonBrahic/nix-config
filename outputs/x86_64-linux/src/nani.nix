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
    base.zram
    base.zsh

    opt.greetd 
    opt.fhs
  ];

  homeModules = with modulesRoot.home; [
    base.archive
    base.git
    base.xdg
    base.container
    base.nix
    base.home

    opt.sway
    opt.chrome
    opt.discord
    opt.encryption
    opt.fetch
    opt.obsidian
    opt.password
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
    hostName = "nani";
    rootUUID = "/dev/disk/by-uuid/29e0b67d-95c0-4090-9ff3-6f779bb3684d";
    root
  };
  
  outputVars = vars.users.tahlon // hardwareVars;

in
{
  nixosConfigurations = {
    "${hostName}" = systemTemplate { inherit args modules; vars = tempVars; };
  };
}
