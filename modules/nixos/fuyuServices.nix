{
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        #PassswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
  services = {
    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "hibernate";
      powerKeyLongPress = "poweroff";
    };
  };
  hardware.sensor.iio.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
}
