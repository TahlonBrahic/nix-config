{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    fuyuNoKosei = {
      compositor.hyprland.enable = true;
      services.laptop.enable = true;
      yubikey.enable = true;
    };
  };
}
