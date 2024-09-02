{
  inputs
  ...
} @ args:
  let
  name = "athena";
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
in {
  nixosConfigurations = {
    "${name}" = args;
  };
}
