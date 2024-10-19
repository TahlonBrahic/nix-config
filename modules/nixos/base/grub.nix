{
  lib,
  vars,
  ...
}:
if vars.hostName == "shilo"
then {}
else {
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
    };
  };
}
