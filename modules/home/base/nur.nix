{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.nur.hmModules.nur
  ];
}
