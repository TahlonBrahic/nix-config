{pkgs, lib, ...}:
let
  # Function that writes a shell application to the Nix store then returns its path 
  writeShellApplication: = {
    name ? "User-made script",
    text ? "",
    dependencies ? [],
  }:
    lib.getExe (pkgs.writeShellApplication {
      inherit name text;
      runtimeInputs = with pkgs; [coreutils gnugrep systemd] ++ dependencies;
    });
  }
in 
  writeShellApplication
