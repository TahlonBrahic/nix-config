{haumea}: {
  varsRoot = haumea.lib.load {
    src = ../vars;
    loader = [haumea.lib.matchers.nix haumea.lib.matchers.yaml];
  };
}
