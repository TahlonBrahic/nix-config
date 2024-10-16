{
  lib,
  vars,
  ...
}:
if vars.name == "tbrahic"
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
