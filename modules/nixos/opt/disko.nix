{
  vars,
  inputs,
  hostname,
  ...
}: {
  imports = [inputs.disko.nixosModules.disko];
  disko.devices = vars.${hostname}disko;
}
