{ lib, ... }: 

{
  boot.loader.grub = {
    enable = true;
  };
}
