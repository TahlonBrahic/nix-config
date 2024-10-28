{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  programs = {
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
