{ inputs, lib, flake-utils, ...}:
{
  /* Pre-defined flake of Nix systems*/
  inherit (inputs) systems nixpkgs;

  /* Expose flake-parts debug interface */
  debug = true;

  /*
  A central set of nixpkgs instance for all systems. It's made available as flake-parts module
  argument and intended to be used everywhere where nixpkgs is needed, so less duplicated instances
  have to be created and there's only one central nixpkgs config.

  Note that this is a top-level flake-parts module argument, not a `perSystem` argument, because
  it's not created per system, instead it has all systems at once.
  */

  /* https://github.com/t184256/nix-on-droid#usage-with-nix-on-droid */
  mkNixOnDroidSystemPackage = name: config: {${config.pkgs.stdenv.system}.${name} = config.activationPackage;};

  nixOnDroidPackages =
    lib.mapAttrsToList mkNixOnDroidSystemPackage
    (removeDefault inputs.self.nixOnDroidConfigurations);
      

  flake = {
    nixosConfigurations = {
      
    };

    nixOnDroidConfigurations {
      default = input.self.nixOnDroidConfigurations.cursor;
    };

    
    };
  };
} 
