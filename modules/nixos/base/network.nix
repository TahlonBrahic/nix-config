{ config, vars, ... }:

{
  networking.hostName = vars.hostName;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
