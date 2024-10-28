{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  programs = {
    lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
