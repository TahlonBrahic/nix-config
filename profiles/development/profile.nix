{ }:

{
  outputs = inputs@{ self, ... }:
    let
      developmentProfile = {
        username = "devtahlon";
        name = "tahlon";
        email = "tahlonbrahic@proton.me";
        defaultWM = "hyprland";
        defaultDM = "sddm";
        terminalEmulator = "kitty";
        shell = "zsh";
        editor = "neovim";
      }
    in {
      homeConfiguration = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            (./. +)
          ]
        };
      };
    };
}
