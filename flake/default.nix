/* Entry point for the flake-parts module system */

{
  imports = [
    ./android.nix
    ./lib.nix
    ./nixos.nix
    ./shell.nix
  ];
}
