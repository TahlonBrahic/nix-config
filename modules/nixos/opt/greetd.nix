{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.services.greetd;
in {
  # Define options
  options.services.greetd = {
    minimal = mkOption {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
      user = "greeter";
    };
    tui = mkOption {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
      user = "greeter";
    };  
  };

config = {
  services.greetd = {
    enable = true;
    settings = {
      default_sessions = cfg.options;
      };
    };
  };
}
