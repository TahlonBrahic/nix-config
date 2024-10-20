{
  pkgs,
  lib,
  ...
}:
  {
    name ? "User-made script",
    script ? "",
    dependencies ? []
  }:
  # Function that writes a shell application to the Nix store then returns its path 
    lib.getExe (pkgs.writeShellApplication {
    inherit name; 
    text = script;
    runtimeInputs = with pkgs; [coreutils gnugrep systemd] ++ dependencies; })
