{ config, lib, pkgs, ... }:

{
  imports = [
  #   ./yoru/default.nix
  #  ./shilo/default.nix
    ./athena
  #  ./tahlon-laptop/default.nix
  #  ./tahlon-desktop/default.nix
  ];
  
  #sops = lib.mkIf (isInstall && username == "tahlon") {
  #  age = {
  #    keyFile = "/home/tahlon/.config/sops/age/keys.txt"
  #    generateKey = false;
  #  };
  #  defaultSopsFile = ../secrets/secrets.yaml
  #  secrets = {
  #    test-key = { };
  #    homepage-env = {};
  #  };
  #};
}
