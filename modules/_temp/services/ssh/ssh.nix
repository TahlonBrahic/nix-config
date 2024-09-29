{ lib, pkgs, ... }: 
{
  servers.openssh = {
    enable = true;
    settings.PasswordsAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
