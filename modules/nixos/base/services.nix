{ pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
    };
    keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          capslock = "overload(control, esc)";
	  esc = "capslock"
	  # Map right shift to back space
	};
      };
    };
  };
}
