{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot varsRoot systemTemplate;

  # TODO: I would like to abstract how I import these as I do it for each host.
  nixModules = with modulesRoot.nixos; [
    ../../../hosts/fukushyuu/hardware-configuration.nix
    base.boot
    base.clamav
    base.env
    base.fail2ban
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

  # TODO: I would like to abstract how I pass users to systemTemplate.
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
  
  hostName = "fukushyuu";
  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
    ] ++ nixModules;
    home = [
    ] ++ homeModules;
  };

  userVars = vars.users.amy;
in
{
  nixosConfigurations = {
    "${hostName}" = systemTemplate { inherit args modules; vars = userVars;};
  };
}
