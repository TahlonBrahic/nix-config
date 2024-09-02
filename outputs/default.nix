{ self, nixpkgs, ... } @ inputs:

let
  inherit (inputs.nixpkgs) lib;

  tempArgs = inputs //
    {
      pkgs-unstable = import inputs.nixpkgs-unstable {
        config.allowUnfree = true;
      }; 
      pkgs-stable = import inputs.nixpkgs {
        config.allowUnfree = true;
      };
    };

  args = { inherit inputs tempArgs; };

  # Import from src/athena.nix, relative to the current directory
  allSystems = {
    athena = import ./src/athena.nix args;
  };

in 
{
  # Export the nixosConfigurations
  nixosConfigurations = {
    athena = allSystems.athena.nixosConfigurations.athena;
  };
}

