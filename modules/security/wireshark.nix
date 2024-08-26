{ config, pkgs, lib, ... }:
{
  environments.systemPackages = [
    pkgs.wireshark
  ];
}
