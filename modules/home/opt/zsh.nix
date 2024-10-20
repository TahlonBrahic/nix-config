{
  pkgs,
  vars,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
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
  # Use this to only declare ZSH in home-manager
  home.sessionVariables.SHELL = "/etc/profiles/per-user/${vars.username}/bin/zsh";
  config.programs.zsh.enable = true;
}
