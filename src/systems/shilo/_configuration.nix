{lib, ...}: {
  kosei = {
    audio.enable = false;
    boot.enable = false;
    displayManager.enable = false;
    RGB.enable = false;
    virtualization.wsl.enable = true;
    wsl.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  environment.etc."resolv.conf".source = lib.mkForce /etc/resolv.conf;
}
