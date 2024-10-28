{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
