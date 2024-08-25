{ config, lib, pkgs, ... }
{
  imports = [
    ./yoru/default.nix
    ./shilo/default.nix
    ./athena/default.nix
    ./tahlon-laptop/default.nix
    ./tahlon-desktop/default.nix
  ];
  
  sops = lib.mkIf (isInstall && username == "tahlon") {
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt"
      generateKey = false;
    };
    defaultSopsFile = ../secrets/secrets.yaml
    secrets = {
      test-key = { };
      homepage-env = {};
    };
  };
}
