{
  fuyuNoKosei = {
    boot.enable = true;
    displayManager.enable = true;
    laptopSupport = {
      enable = true;
      enableHyprlandSupport = true;
    };
    microphone.enable = true;
    syncthing.enable = true;
    secrets.defaultSopsFile = ../../../secrets/secrets.yaml;
    ssh.enable = true;
    yubikey.enable = true;
  };
}
