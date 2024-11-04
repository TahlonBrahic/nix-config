{pkgs-stable, ...}: {
  programs.zellij = {
    package = pkgs-stable.zellij;
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
