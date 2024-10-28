{sysconfig ? (import <nixpkgs/nixos> {}).config, ...}:
{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+p" = "paste";
    };
  };
}
