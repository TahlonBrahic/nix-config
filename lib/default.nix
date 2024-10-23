{
  haumea,
  ...
}@inputs: {
  # Reusable functions
  systemTemplate = import ./systemTemplate.nix;
  droidTemplate = import ./droidTemplate.nix;

  writeShellApplicationWrapper = import ./writeShellApplicationWrapper.nix {inherit inputs;};
  writeWaybarModule = import ./writeWaybarModule.nix {inherit inputs;};
  vars = import ./vars.nix {inherit haumea inputs;};
  optionalModules = import ./optionalModules.nix {inherit haumea inputs;};
  overlays = import ./overlays.nix {inherit haumea inputs;};
  baseNixosModules = import ./baseNixosModules.nix {inherit haumea inputs;};
  baseHomeModules = import ./baseHomeModules.nix {inherit haumea inputs;};
}
