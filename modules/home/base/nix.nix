{pkgs, ...}: {
  home.packages = with pkgs; [
    nix-output-monitor
    hydra-check
    #nix-index
    nix-init
    nix-melt
    nix-tree
  ];

  nixpkgs.config.allowUnfree = true;
}
