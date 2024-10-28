{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  programs = {
    chromium = {
      enable = true;
    };
  };
}
