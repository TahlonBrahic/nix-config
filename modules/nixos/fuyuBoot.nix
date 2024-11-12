{hostName, ...}:
if hostName == "shilo"
then {}
else {
  config = {
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
      };
    };
  };
}
