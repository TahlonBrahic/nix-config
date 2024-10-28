{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    };
  };
}
