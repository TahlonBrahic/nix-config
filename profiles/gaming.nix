environment.systemPackages = with pkgs; [
  steam
  lutris
  wine
  mangohud
  gamemode
}

# GameScope Compositor integration
programs.steam.gamescopeSession.enable = true;

# ProtonGE might need to be handrolled or found in a flake
