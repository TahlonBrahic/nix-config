{
  vars,
  inputs,
  hostName,
  ...
}: {
  imports = [inputs.disko.nixosModules.disko];
  disko.devices = vars.${hostName}.disko;
}
