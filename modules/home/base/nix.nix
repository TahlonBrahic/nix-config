{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-index-database.hmModules.nix-index];

  home.packages = with pkgs; [
    nix-output-monitor
    hydra-check
    nix-init
    nix-melt
    nix-tree
  ];

  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    nix-index-database.comma.enable = true;
  };

  nixpkgs.overlays = [
    inputs.nur.hmModules.nur
  ];
}
