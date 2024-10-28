{
  programs = {
    bash = {
      enable = true;
      shellOptions = [
        vi
      ];
      shellAliases = {
        la = "ls -al";
        ll = "ls -l";
        ".." = "cd ..";
        switch = "sudo nixos-rebuild switch"
      };
    };
  };
  environment.pathsToLinks = ["/share/bash-completion"];
}
