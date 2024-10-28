{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  programs = {
    broot = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
