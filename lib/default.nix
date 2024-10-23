{haumea, ...}: {
  # Reusable functions
  systemTemplate = import ./systemTemplate.nix;
  droidTemplate = import ./droidTemplate.nix;
  writeShellApplicationWrapper = import ./writeShellApplicationWrapper.nix;
  writeWaybarModule = import ./writeWaybarModule.nix;

  # Haumea-derived Attribute Sets
  # TODO: Map these attributes
  lib = import ./lib.nix {inherit haumea;};
  modules = import ./modules.nix {inherit haumea;};
  vars = import ./vars.nix {inherit haumea;};
  overlays = import ./overlays.nix {inherit haumea;};
  baseNixosModules = import ./baseNixosModules.nix {inherit haumea;};
  baseHomeModules = import ./baseHomeModules.nix {inherit haumea;};
}
