{ config, lib, pkgs, vars, ...}:

{
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''rm -f ${config.home.homeDirectory}/.gitconfig'';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = vars.userfullname;
    userEmail = vars.useremail;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      url = {
        "ssh://git@github.com/TahlonBrahic" = {
          insteadOf = "https://github.com/TahlonBrahic";
        };
      };
    };
  };
}
