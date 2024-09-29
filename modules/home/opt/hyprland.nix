{ vars, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
	"MOZ_ENABLE_WAYLAND, 1"
	"MOZ_WEBRENDER, 1"
	"XDG_SESSION_TYPE, wayland"
	"WLR_NO_HARDWARE_CURSORS, 1"
	"WLR_RENDERER_ALLOW_SOFTWARE, 1"
      ];
      input = {
        follow_mouse = 2;
	mouse_refocus = false;
	bind = let workspaces = [ "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
	  directions = rec {
	    left = "l";
	    right = "r";
	    up = "u";
	    down = "d";
	    h = left;
	    l = right;
	    k = up;
	    j = down;
	  };
	in
	[
	  "SUPER,t,exec,kitty"
	  "SUPER,f,exec,librewolf"
	  "SUPER,q,killactive"
	  "SUPER,s,togglespecialworkspace"
	  "SUPER,g,togglegroup"
	]
      };
    # monitor = [
      # TODO: add a lib.MkIf here for each host to use
      # "DP-1, resolutions, 0x0, 1" 
    # ];
    general = {
      gaps_in = 6;
      gaps_out = 6;
      border_size = 3;
      resize_on_border = true;
      hover_icon_on_border = true;
    };
  };
}
