{
  vars,
  inputs,
  ...
}: {
  imports = [inputs.disko.nixosModules.disko];
  disko.devices = vars.disko;
}
