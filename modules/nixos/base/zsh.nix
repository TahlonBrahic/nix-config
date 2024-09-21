{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        git
	kubectl
	history
	emoji
	encode64
	sudo
	copydir
	copyfile
	copybuffer
        history
      ];
      theme = "jonathan";
    };
  };

  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh; 

  programs.nix-index.enableZshIntegration = true;
}
