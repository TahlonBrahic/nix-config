{
  lib,
  customVars,
  ...
}:
if customVars.hostName == "shilo"
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
