{
  lib,
  config,
  ...
}: {
  boot.loader = lib.mkOptionDefault {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
      useOSProber = true;
    };
  };
}
