{
  description = "NixOS configuration with dynamic display managers and window managers";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        tahlon-desktop = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./hosts/tahlon-desktop/default.nix
            ./profiles/gaming.nix    # Select the gaming profile

            # Select the desired window manager
            ./modules/window-managers/gnome.wayland.nix  # GNOME with Wayland
            # ./modules/window-managers/gnome.x11.nix    # GNOME with X11
            # ./modules/window-managers/hyprland.nix
            # ./modules/window-managers/i3.nix
            # ./modules/window-managers/sway.nix

            # Select the appropriate display manager
            ./modules/display-managers/gdm.nix    # Use GDM
            # ./modules/display-managers/lightdm.nix  # Use LightDM
            # ./modules/display-managers/sddm.nix     # Use SDDM

            ./home-manager/default.nix
          ];
        };

        # Other machine configurations
      };
    };
}

