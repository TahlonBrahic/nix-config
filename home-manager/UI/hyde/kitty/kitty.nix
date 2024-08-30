{ config, pkgs, ... }:

{
  home.file.".config/kitty/kitty.conf".text = builtins.readFile ./kitty.conf
  home.file.".config/kitty/theme.conf".text = builtins.readFile ./theme.conf

  programs.kitty = {
    enable = true;
  };
}
