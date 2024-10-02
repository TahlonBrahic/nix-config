{ vars, ...}: 

let
  inherit (vars) username;
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";   

    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
