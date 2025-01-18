{
  fuyuNoKosei = {
    boot.enable = true;
    displayManager = {
      enable = true;
      lightdm.enable = true;
    };
    gaming.enable = true;
    GNOME.enable = true;
    microphone.enable = true;
    syncthing.enable = true;
    secrets.defaultSopsFile = ../../secrets/secrets.yaml;
    ssh.enable = true;
  };
}
