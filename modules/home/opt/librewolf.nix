{ config, lib, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.clearOnShutdown.cookies" = false;
    };
  };
}
