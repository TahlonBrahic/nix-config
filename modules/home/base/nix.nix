{pkgs, ...}: {
  home.packages = with pkgs; [
    nix-output-monitor
    hydra-check
    nix-init
    nix-melt
    nix-tree
  ];

  nixpkgs.config.allowUnfree = true;
}
