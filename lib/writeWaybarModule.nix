{
  pkgs,
  writeCustomShellApplication,
  ...
}: {
  name ? "User-made Waybar Module",
  dependencies ? [],
  script ? "",
  text ? "",
  tooltip ? "",
  alt ? "",
  class ? "",
  percentage ? "",
}:
# Function that creates a custom Waybar Module
writeCustomShellApplication {
  inherit name;
  dependencies = [pkgs.jq] ++ dependencies;
  script = ''
    ${script}
    jq -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  '';
}
