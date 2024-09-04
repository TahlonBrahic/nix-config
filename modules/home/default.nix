{ ... }:

{
  home = {
    packages = with pkgs; [ #this is temporary
      hello
    ];
    username = "tahlon";
    homeDirectory = "/home/tahlon";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}

