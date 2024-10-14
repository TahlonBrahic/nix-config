{vars, pkgs, ...}: {
  users.mutableUsers = false;

  users.users."${vars.username}" = {
    home = "/home/${vars.username}";
    inherit (vars) initialHashedPassword;
    isNormalUser = true;
    shell = pkgs."${vars.shell}";
    extraGroups = [
      "${vars.username}"
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };
}
