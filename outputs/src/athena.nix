{
  inputs,
  system,
  ...
} @ args:
  let
  name = "athena";
  system = "x86_64-linux";
  nixpkgs = import nixpkgs {inherit system;};
  base-modules = {
    nixos-modules = [
      # common
      "../../modules/security/default.nix"
      # host specific
      # "hosts/${name}"
    ];
    home-modules = [
      # common
      # "../../"
      # host specific
      # "hosts/${name}/home.nix"
    ];
  };
in {
  nixosConfigurations = {
    "${name}" = args;
  };
}
