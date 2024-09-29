{ ... }@args:

{
  varsRoot = args.inputs.haumea.lib.load {
    src = ../vars;
    inputs = args;
  };
}
