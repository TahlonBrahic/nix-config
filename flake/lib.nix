{flake-utils, ...};
{
  inherit (flake-utils.lib) eachDefaultSystem;
  arguments = eachDefaultSystem (system: {
    inherit inputs lib;
    inherit (pkgs.${system}) pkgs;
    inherit (localLib.${system}) localLib;
    inherit (localLib.${system}.localLib) vars overlays;
  });

  localLib = eachDefaultSystem (system:
    import ../lib {
      inherit inputs system;
      pkgs = pkgs.${system};
    });

  pkgs = eachDefaultSystem (system: import nixpkgs {inherit system; config.allowUnfree = true;});

}
