{ lib, config, pkgs, ... }:

let
  greetdSettings = {
    command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
    user = "greeter";
  };
in {
   environment.systemPackages = [
    pkgs.greetd.tuigreet
  ];
  # Configuration for the greetd service
  services.greetd = {
    enable = true;  # Enable greetd service
    settings = greetdSettings;  # Use defined greetd settings
  };
}

