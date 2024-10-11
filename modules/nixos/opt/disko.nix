# Example to create a bios compatible gpt partition
{ lib, vars, ... }:

{
  disko.devices = vars.disko;
}
