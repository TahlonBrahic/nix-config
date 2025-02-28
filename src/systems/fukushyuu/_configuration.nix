{inputs, ...}: {
  kosei = {
    boot.enable = true;
    displayManager = {
      enable = true;
      lightdm.enable = true;
    };
    gaming.enable = true;
    GNOME.enable = true;
    microphone.enable = true;
    ssh.enable = true;
  };
}
