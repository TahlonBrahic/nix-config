{lib, ...}: {
  fuyuNoKosei = {
    audio.enable = false;
    boot.enable = false;
    secrets.defaultSopsFile = ../../../../secrets/secrets.yaml;
    virtualization.wsl.enable = true;
    displayManager.enable = false;
    RGB.enable = false;
  };

  environment.etc."resolv.conf".source = lib.mkForce /etc/resolv.conf;
}
