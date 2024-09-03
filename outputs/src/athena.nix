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
      # "../../"
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

  modules-hyprland = {
    nixos-modules =
      [
        {
          ../../modules/clamav/
        }
      ]
      # ++ base-modules.nixos-modules;
    home-modules =
      [
      ]
      # ++ base-modules.home-modules;
  };
  systemConfiguration = modu
in {
  nixosConfigurations = {
    "${name}" = args;
  };
}
