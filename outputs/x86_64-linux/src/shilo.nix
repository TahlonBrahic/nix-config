{
  inputs,
  lib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (lib) optionalModules systemTemplate;

  customModules = {
    nixos = with optionalModules.nixos; [
      wsl
    ];

    homeManager = with optionalModules.home; [
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
