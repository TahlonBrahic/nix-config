{ self, nixpkgs, ... } @ inputs: let
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

    args = {inherit inputs tempArgs; };

    systems = { 
      import ./src (args // {system = "x86_64-linux";});
    };

    packages = x: lib.genAttrs (builtins.attrNames allSystems) (system: allSystems.${system}.packages or {} );
    in
    {
      inherit packages;
    }   
