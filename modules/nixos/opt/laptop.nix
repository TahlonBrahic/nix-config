{
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
}
