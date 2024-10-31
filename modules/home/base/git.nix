{
  programs.git = {
    enable = true;

    lfs.enable = true;

    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };

    userName = "TahlonBrahic";
    userEmail = "tahlonbrahic@gmail.com";

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
