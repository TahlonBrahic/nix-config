{ pkgs, ... }:

{
  services = {
    openssh = {
      enable = true;
      settings = PermitRootLogin = "no";
      PassswordAuthentication = false;
      KbdInteractiveAuthentication = false;
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
