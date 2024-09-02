{
  pkgs,
  config,
  username,
  ...
}: {
  programs = {
    chromium = {
      enable = true;
    };
  };
}
