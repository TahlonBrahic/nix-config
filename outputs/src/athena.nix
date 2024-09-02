{
  inputs,
  lib,
  system,
  ...
} @ args:

{
  name = "athena";
  base-modules = {
    nixos-modules = [
      # common
      # "secrets/nixos.nix"
      # "modules/nixos/desktop.nix"
      # host specific
      # "hosts/idols-${name}"
    ];
    home-modules = [
      # common
      # "../../home/"
      # host specific
      # "hosts/${name}/home.nix"
    ];
  };
}
