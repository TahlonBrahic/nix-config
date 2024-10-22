{
  customVars,
  pkgs,
  ...
}: {
  users.mutableUsers = false;

  users.users."${customVars.username}" = {
    home = "/home/${customVars.username}";
    inherit (customVars) initialHashedPassword;
    isNormalUser = true;
    shell = pkgs."${customVars.shell}";
    extraGroups = [
      "${customVars.username}"
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };
  
  programs.${customVars.shell}.enable = true;
}
