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

  # Define allSystems for all your x86_64 Linux configurations
  allSystems = {
    athena = import ../src/athena.nix { inherit args; };
  };

in 
{
  # Export the nixosConfigurations
  nixosConfigurations = {
    athena = allSystems.athena.nixosConfigurations.athena;
  };
}

