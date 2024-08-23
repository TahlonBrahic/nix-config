{ config, pkgs, ... }:
{
  # Import Home Manager modules
  imports = [ <home-manager/modules/default.nix> ];

  home = {
    username = "tahlon";

    sessionVariables = {
      EDITOR = "nvim";
    };

    programs = {
      zsh = {
        enable = true;
        ohMyZsh = {
          enable = true;
        };
      };

      neovim = {
        enable = true;
        plugins = [ pkgs.vimPlugins.gruvbox ];
      };
    };
  };
}

