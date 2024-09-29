{ vars ? {}, ... }:

{
  home = {
    username = "tahlon";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
