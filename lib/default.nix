{haumea, ...}: {
  # Reusable functions
  systemTemplate = import ./systemTemplate.nix;
  writeShellApplication = import ./writeShellApplication.nix;
  writeWaybarModule = import ./writeWaybarModule.nix;

  # Haumea-derived Attribute Sets
  libRoot = import ./libRoot.nix {inherit haumea;};
  modulesRoot = import ./modulesRoot.nix {inherit haumea;};
  varsRoot = import ./varsRoot.nix {inherit haumea;};
  overlaysRoot = import ./overlaysRoot.nix {inherit haumea;};
  baseNixosModules = import ./baseNixosModules.nix {inherit haumea;};
  baseHomeModules = import ./baseHomeModules.nix {inherit haumea;};
}
