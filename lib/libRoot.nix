{haumea}: let
  libRoot = haumea.lib.load {
    src = ./.;
  };
in
  libRoot
