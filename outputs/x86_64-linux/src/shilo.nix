{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (customLib) modulesRoot overlaysRoot systemTemplate;

  customModules = {
    nixos = with modulesRoot.nixos.opt; [
      wsl
    ];

    homeManager = with modulesRoot.home.opt; [
      broot
      encryption
      fetch
      firefox
      fish
      fzf
      lsd
      nvchad
      nix-index
      starship
      zellij
      zoxide
    ];
  };

  customVars = vars.users.tbrahic;
in {
  nixosConfigurations = {
    "shilo" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
