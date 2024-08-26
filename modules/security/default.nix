{ config, pkgs, lib, ... }:

{
  imports = [
    ./clamav.nix
    ./fail2ban.nix
    ./wireshark.nix
  ];  
}
