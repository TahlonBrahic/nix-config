{
  pkgs,
  vars,
  lib,
  ...
}:
{
  programs = {
    nix-index.enableZshIntegration = true;
    zsh = {
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
  #programs.fish.enable = fsh true;
  #environment = {
  #  pathsToLink = fsh ["/share/fish"];
  #  enableAllTerminfo = fsh true;
  #};

  # SHARED

  environment.shells = [pkgs.zsh];
  users.defaultUserShell = pkgs.zsh; 
}
