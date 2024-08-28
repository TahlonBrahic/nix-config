{ config, pkgs, inputs, ... }:

let
  mkpgs = import inputs.nixpkgs {
    overlays = [ ./overlays/nvchad.nix];
  };
in {
  imports = [
    inputs.nvchad4nix.homeManagerModules
  ];

  programs.nvchad = {
    enable = true;
    extraPackages = with myPkgs; [
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-language-server
      nixd
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8  
      ]))
    ];
  };
}
