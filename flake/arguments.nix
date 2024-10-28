{lib, ...}: {

  _module.args.pkgsBySystem = lib.attrsets.genAttrs config.systems (system:
    import nixpkgs {
      /*
      If `crossSystem` isn't set, `localSystem` simply sets the system that nixpkgs is built on and
      for.

      Using these options is preferred over setting `system` or `platform`.

      See: https://nixos.org/manual/nixpkgs/stable/#sec-cross-usage
      */
      localSystem = system;

      overlays = [ inputs.self.overlays.unstable ]

      config = { allowUnfree = true; };
    }
  );

  /*
  This nixpkgs overlay includes the nixpkgs variants I use beside the main stable nixpkgs as
  `pkgs.<variant>` in `pkgs`, so they can be accessed directly through the same `pkgs` value.
  */
  flake.overlays.unstable = (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      localSystem = prev.system;
      config = prev.config;
    };
  });


  legacyPackages = let
    removeDefault = lib.attrsets.filterAttrs (name: _: name != "default");

    mkSystemPackage = name: config: {
      ${config.pkgs.stdenv.system}.${name} = config.config.system.build.toplevel;
    };

    nixosPackages = lib.mapAttrsToList mkSystemPackage (removeDefault inputs.self.nixosConfigurations);

    /*
    Note: the nix-on-droid activation package can't be evaluated purely, as there are hardcoded
    store paths. Even impurely, they rely on the nix-on-droid binary cache to be configured to pull
     that store path from.

    https://github.com/t184256/nix-on-droid#usage-with-nix-on-droid
    */
    mkNixOnDroidSystemPackage = name: config: {
      ${config.pkgs.stdenv.system}.${name} = config.activationPackage;
    };

    nixOnDroidPackages = lib.mapAttrsToList mkNixOnDroidSystemPackage (removeDefault inputs.self.nixOnDroidConfigurations);
  in
    lib.mkMerge (nixosPackages ++ homePackages ++ nixOnDroidPackages);

}
