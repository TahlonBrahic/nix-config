{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  outputs = inputs @ {
    flake-utils,
    nixpkgs,
    ...
  }: let
    inherit (inputs.nixpkgs) lib;
  in
    flake-utils.lib.eachDefaultSystemPassThrough (system: let
      basePkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs =
        basePkgs.appendOverlays
        [
          inputs.fuyuvim.overlays.default
          inputs.nur.overlays.default
        ];
    in {
      nixosConfigurations = let
        loadSystems = inputs.haumea.lib.load {
          src = ./src/systems;
          loader = inputs.haumea.lib.loaders.verbatim;
        };
        systemNames = builtins.attrNames loadSystems;
      in
        lib.attrsets.genAttrs systemNames
        (systemName:
          import ./src/systems/${systemName}/${systemName}.nix {inherit inputs lib pkgs;});
    })
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      devShells = import ./src/dev/shell.nix {inherit pkgs;};
    });

  inputs = {
    assets = {
      url = "github:TahlonBrahic/assets";
      flake = false;
    };
    kosei = {
      url = "github:TahlonBrahic/fuyu-no-kosei";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fuyu-no-nur = {
      url = "github:TahlonBrahic/fuyu-no-nur";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    fuyuvim = {
      url = "github:TahlonBrahic/fuyu-no-neovim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        fuyu-no-nur.follows = "fuyu-no-nur";
      };
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    jeezyvim = {
      url = "github:LGUG2Z/JeezyVim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    sops-nix = {
      url = "github:TahlonBrahic/sops-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
