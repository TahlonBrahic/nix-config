{
  name ? "customScript",
  text, # script
  dependencies ? [],
}:
# Wrapper that returns the path of a programs written as a derivation to the nix store
let
  inherit lib pkgs; 
  writeShellApplication = lib.getExe (pkgs.writeShellApplication {
  inherit name text;
  runtimeInputs = with pkgs; [coreutils gnugrep systemd] ++ dependencies;})
in {
  writeShellApplication }