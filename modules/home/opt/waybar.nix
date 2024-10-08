{ configs, pkgs, vars, ... }:

{
  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBair = {
   	  layer = "top";
	  position = "top";
	  height = 30;
 
          # Modules
          modules-left = [ "cpu" ];        

	  "sway/mode" = {
	    format = "<span style=\"italic\">{}</span>";
	  };
	  "sway/workspaces" = {
	    on-click = "activate";
	    sort-by-number = true;
	  };
        };
      };
    };
  };
}
