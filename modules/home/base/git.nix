{vars, ...}: {
  #home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''rm -f ${config.home.homeDirectory}/.gitconfig'';

  programs.git = {
    enable = true;

    lfs.enable = true;

    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };

    userName = vars.username;
    userEmail = vars.email;

    extraConfig = {
      init.defaultBranch = "main";

      push = {
        default = "current";
        autoSetupRemote = true;
      };

      pull = {
        rebase = true;
      };

      merge = {
        conflictstyle = "diff3";
      };

      diff = {
        colorMoved = "default";
      };

      url = {
        "ssh://git@github.com/TahlonBrahic" = {
          insteadOf = "https://github.com/TahlonBrahic";
        };
      };
    };
  };
}
