{
  inputs,
  lib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (lib) modules systemTemplate;

  customModules = {
    nixos = with modules.nixos.opt; [
      wsl
    ];

    homeManager = with modules.home.opt; [
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
