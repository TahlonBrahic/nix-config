{
  lib,
  hostName,
  ...
}: {
  networking = {
    inherit hostName;
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
