{
  pkgs,
  vars,
  ...
}: {
  home.packages = with pkgs; [
    google-chrome
  ];
}
