{ lib, ... }:

{
  imports = lib.scanPaths./.;
}