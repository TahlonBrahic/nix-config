{lib, ...}: {
  fuyuNoKosei = {
    yubikey.enable = false;
    secrets.defaultSopsFile = ../../../../secrets/secrets.yaml;
    services.gamemode.enable = true;
  };
  users.users."tahlon".password = "p";
  users.users."tahlon".hashedPasswordFile = lib.mkForce null;
  users.users."root".password = "p";
  users.mutableUsers = lib.mkForce true;
}
