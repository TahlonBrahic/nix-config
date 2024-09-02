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

  allSystems = import ./src/athena.nix;
in 
{
  nixosConfigurations = allSystems.nixosConfigurations;
}

