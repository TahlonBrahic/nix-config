{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip
    xz
    zstd
    p7zip
  ];
{
