{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [

      # LSPs
      ansible-language-server
      dockerfile-language-server-nodejs
      haskell-language-server
      yaml-language-server

      # DAPs
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-ui
      vimPlugins.nvim-dap-python
      vimPlugins.nvim-dap-virtual-text

      # Linters and Formatters
      actionlint
      ansible-lint
      ast-grep
      commitlint
      gitlint
      shellharden
      textlint
      yamllint

    ];
  };
}
