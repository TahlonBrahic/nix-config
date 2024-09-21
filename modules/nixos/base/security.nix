{ config, pkgs, ... }:

{
  services.dbus.apparmor = "enabled";

  security.apparmor = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    apparmor-bin-utils
    apparmor-profiles
    apparmor-parser
    apparmor-kernel-patches
    apparmor-pam
    apparmor-utils
    libapparmor
  ];
}
