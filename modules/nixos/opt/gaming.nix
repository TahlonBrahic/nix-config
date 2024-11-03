{pkgs, ...}:
#inherit (inputs) nix-gaming;
#inherit (lib) optionalString;
#hyprlandCfg = config.wayland.windowManager.hyprland.enable;
#hyprlandGamemode = config.hyprland.gamemode;
#gnomeCfg = config.desktopManager.gnome.enable;
#gnomeGamemode = config.gnome.gamemode;
#startscript = (optionalString gnomeCfg gnomeGamemode.startscript) + (optionalString hyprlandCfg hyprlandGamemode.startscript);
#endscript = (optionalString gnomeCfg gnomeGamemode.endscript) + (optionalString hyprlandCfg hyprlandGamemode.startscript);
{
  /*
  Usage:
    1. For games/launchers which integrate GameMode support:
       https://github.com/FeralInteractive/GameMode#apps-with-gamemode-integration
       simply running the game will automatically activate GameMode.
    2. For others, launching the game through gamemoderun: `gamemoderun ./game`
    3. For steam: `gamemoderun steam-runtime`
  */

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = -5;
      };
      gpu = {
        apply_gpu_optimizations = "accept-responsibility";
        gpu_device = 0;
      };
      #custom = {
      #  start = startscript.outPath;
      #  end = endscript.outPath;
      #};
    };
  };

  # REF: https://github.com/fufexan/nix-gaming/#pipewire-low-latency
  services.pipewire.lowLatency.enable = true;
  #imports = [
  #  nix-gaming.nixosModules.pipewireLowLatency
  #];

  programs.steam = {
    # Some location that should be persistent:
    #   ~/.local/share/Steam - The default Steam install location
    #   ~/.local/share/Steam/steamapps/common - The default Game install location
    #   ~/.steam/root        - A symlink to ~/.local/share/Steam
    #   ~/.steam             - Some Symlinks & user info
    enable = true;

    # NOTE: Fix Gamescope inside Steam
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          keyutils
          libkrb5
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
        ];
    };
  };
}
