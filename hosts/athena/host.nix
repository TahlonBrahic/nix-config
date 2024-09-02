{ ... }:

{
  let
    hostName = "athena";
  in {
    
    networking = {
      inherit hostName;

      networkmanager.enable = true;
    };

    system.stateVersion = "24.05";
  };
}
