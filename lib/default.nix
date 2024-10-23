{
  inputs,
  haumea,
  pkgs,
}: {
  # Reusable functions
  systemTemplate = import ./systemTemplate.nix;
  droidTemplate = import ./droidTemplate.nix;
  writeShellApplicationWrapper = import ./writeShellApplicationWrapper.nix;
  writeWaybarModule = import ./writeWaybarModule.nix;

  # Haumea-derived Attribute Sets
  # TODO: Map these attributes
  vars = import ./vars.nix {inherit inputs;};
  optionalModules = import ./optionalModules.nix {inherit haumea;};
  overlays = import ./overlays.nix {inherit haumea;};
  baseNixosModules = import ./baseNixosModules.nix {inherit haumea;};
  baseHomeModules = import ./baseHomeModules.nix {inherit haumea;};
}
