{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs = {
    fuyuNoKosei = {
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
        nixvim.follows = "nixvim";
        fuyuNoNur.follows = "fuyu-no-nur";
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
        nixvim.follows = "nixvim";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
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
      url = "github:Mic92/sops-nix";
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
  outputs = inputs @ {
    self,
    flake-utils,
    ...
  }: let
    inherit (inputs.nixpkgs) lib;
  in
    flake-utils.lib.eachDefaultSystemPassThrough (system: {
      nixosConfigurations = let
        loadSystems = inputs.haumea.lib.load {
          src = ./partitions/systems;
          loader = inputs.haumea.lib.loaders.verbatim;
        };
        systemNames = builtins.attrNames loadSystems;
      in
        lib.attrsets.genAttrs systemNames
        (systemName:
          import ./partitions/systems/${systemName}/${systemName}.nix {inherit self inputs lib;});
    })
    // flake-utils.lib.eachDefaultSystem (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      devShells = import ./shell.nix {inherit pkgs;};
    });
}
