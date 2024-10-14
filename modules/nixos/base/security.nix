{pkgs, ...}: {
  security = {
    sudo.wheelNeedsPassword = false;
    apparmor = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
  };

  services.dbus.apparmor = "enabled";

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
