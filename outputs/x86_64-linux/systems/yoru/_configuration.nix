{
  config = {
    services.laptop.enable = true;
    yubikey.enable = true;
    secrets.defaultSopsFile = ../../../../secrets/secrets.yaml;
    displayManager = {option = "tuigreet";};
  };
}
