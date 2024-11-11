{
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        #PassswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
