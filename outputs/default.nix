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

  allSystems = { 
    x86_64-linux = import ../src/athena.nix { inherit args; system = "x86_64-linux"; };
  };

in 
{
  nixosConfigurations = {
    athena = allSystems.x86_64-linux.nixosConfigurations.athena;
  };
}
