{ vars, ...}: 

{
  home = {
    inherit (vars) username;

    stateVersion = "24.05";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
