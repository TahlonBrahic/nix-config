{ config, lib, ... }:

{
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
