{
  pkgs,
  vars,
  lib,
  ...
}: let
  zsh = lib.mkIf (vars.shell == "zsh");
  fsh = lib.mkIf (vars.shell == "fsh");
in {
  # ZSH
  programs = {
    nix-index.enableZshIntegration = zsh true;
    zsh = lib.mkIf zsh {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "kubectl"
          "history"
          "emoji"
          "encode64"
          "sudo"
          "copyfile"
          "copybuffer"
          "history"
        ];
        theme = "jonathan";
      };
    };
  };

  # FSH
  programs.fish.enable = fsh true;
  environment = {
    pathsToLink = fsh ["/share/fish"];
    enableAllTerminfo = fsh true;
  };

  # SHARED

  environment.shells = zsh [pkgs.zsh] || fsh [pkgs.fish];
  users.defaultUserShell = zsh pkgs.zsh || fsh [pkgs.fish];
}
