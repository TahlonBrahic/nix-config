{ ... }:

{
  programs = {
    waybar = {
      enable = true;
      settings = {
        mainBair = {
   	  layer = "bottom";
	  position = "top";
	  height = 24;
	  spacing = 0;
	  #modules-left = [];
	  #modules-center = [];
	  #modules-right = [];
	  "sway/mode" = {
	    format = "<span style=\"italic\">{}</span>";
	  };
	  "sway/workspaces" = {
	    on-click = "activate";
	    sort-by-number = true;
	   # format = "{value}";
	  };
        };
      };
    };
  };
}
